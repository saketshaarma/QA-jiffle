variable "env_name" {
  description = "Environment you want to create"
}

variable "nginx_target_group_public" {
  description = "AWS ALB target Group ARN"
}
variable "nginx_target_group_private" {
  description = "AWS ALB target Group ARN"
}

variable "vpc_subnet" {
  description = "VPC Availability Zones"
  type = list(string)
}
variable "vpc_id" {
  description = "VPC ID"
}

variable "protocol_for_nlb_http_https" {
  default = "TCP"
}

variable "port_http" {
  default = "80"
}
