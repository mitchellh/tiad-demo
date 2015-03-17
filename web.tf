resource "aws_instance" "web" {
    ami = "${var.ami}"
    instance_type = "m3.medium"
    count = "${var.web_servers}"
    key_name = "${var.key_name}"
    security_groups = ["${aws_security_group.web.name}"]

    connection {
        user = "ubuntu"
        key_file = "${var.key_path}"
    }

    // Setup Consul
    provisioner "file" {
        source = "${path.module}/scripts/upstart.conf"
        destination = "/tmp/upstart.conf"
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/scripts/install.sh",
            "${path.module}/scripts/agent.sh",
            "${path.module}/scripts/service.sh",
        ]
    }

    // Setup the web server, install consul-template, and configure it all.
    provisioner "file" {
        source = "${path.module}/scripts/upstart_web.conf"
        destination = "/tmp/upstart.conf"
    }

    provisioner "remote-exec" {
        scripts = [
            "${path.module}/scripts/install_template.sh",
            "${path.module}/scripts/web.sh",
        ]
    }
}

resource "aws_security_group" "web" {
    name = "web"
    description = "Web server security group."

    // Web access
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // These are for maintenance and setup
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
