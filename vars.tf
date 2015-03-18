variable "ami" {
    default = "ami-08faa660"
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

variable "web_servers" {
    default = "2"
    description = "The number of Consul servers to launch."
}

variable "atlas_app" {
    description = "The Atlas name of your infrastructure, ex. username/infra"
}

variable "atlas_token" {
    description = "Atlas API token"
}
