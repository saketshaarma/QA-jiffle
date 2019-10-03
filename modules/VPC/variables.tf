variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR Block of the VPC"
}
variable "instance_tenancy" {
  default = "default"
  description = "Instance tenancy of your VPC"
}

variable "dns_support_for_vpc" {
  default = "true"
  description = "boolean flag to enable/disable DNS support in the VPC"
}

variable "env_name" {
  default = "example"
  description = "Name of the ENV wants to be created"
}
variable "cidr_public" {
  default = "0.0.0.0/0"
}
