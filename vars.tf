variable "ami" {
    default = "ami-3acc7a52"
}

variable "key_name" {
    description = "SSH key name in your AWS account for AWS instances."
}

variable "key_path" {
    description = "Path to the private key specified by key_name."
}

variable "consul_servers" {
    default = "3"
    description = "The number of Consul servers to launch."
}
