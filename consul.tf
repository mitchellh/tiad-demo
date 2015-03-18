resource "aws_instance" "consul_server" {
    ami = "${var.ami}"
    instance_type = "m3.medium"
    key_name = "${var.key_name}"
    count = "${var.consul_servers}"
    security_groups = ["${aws_security_group.consul.name}"]

    connection {
        user = "ubuntu"
        key_file = "${var.key_path}"
    }

    provisioner "file" {
        source = "${path.module}/scripts/upstart.conf"
        destination = "/tmp/upstart.conf"
    }

    provisioner "remote-exec" {
        inline = [
            "echo ${var.consul_servers} > /tmp/consul-server-count",
            "echo ${var.atlas_app} > /tmp/atlas-app",
            "echo ${var.atlas_token} > /tmp/atlas-token",
        ]
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/scripts/install.sh",
            "${path.module}/scripts/server.sh",
            "${path.module}/scripts/service.sh",
        ]
    }
}

resource "aws_security_group" "consul" {
    name = "consul"
    description = "Consul internal traffic + maintenance."

    // These are for internal traffic
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }

    // These are for maintenance and setup
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // So we can set keys directly. Not recommended in production, but
    // good for a demo.
    ingress {
        from_port = 8500
        to_port = 8500
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
