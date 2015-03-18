output "consul_address" {
    value = "${aws_instance.consul_server.0.public_dns}"
}

output "lb_address" {
    value = "${aws_elb.lb.dns_name}"
}
