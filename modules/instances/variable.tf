variable "security_group_edge" {
  description = "Security Group of Nginx"
}

variable "security_group_app" {
  description = "Security Group Capp"
}

variable "security_group_bastion" {
  description = "Security Group bastion"
}

variable "security_group_infra" {
  description = "Infra Security Group"
}

variable "security_group_pgbouncer" {
  description = "Security Group PG Bouncer"
}

variable "key_name" {
  description = "Key Name"
}

variable "env_name" {
  description = "Environment Name"
  default = "QA"
}

variable "lister_port_http" {
  default = "80"
}

variable "lister_nlb_protocol" {
  default = "TCP"
}

variable "instance_type_nginx" {
  default = "t2.micro"
}

variable "instance_type_capp" {
  default = "t2.micro"
}

variable "instance_type_eapp" {
  default = "t2.micro"
}

variable "instance_type_eworker" {
  default = "t2.micro"
}


variable "instance_type_bastion" {
  default = "t2.micro"
}

variable "instance_type_redis" {
  default = "t2.micro"
}

variable "instance_type_pgbouncer" {
  default = "t2.micro"
}

variable "instance_type_docs" {
  default = "t2.micro"
}

variable "instance_type_prometheous1" {
  default = "t2.micro"
}

variable "instance_type_prometheous2" {
  default = "t2.micro"
}

variable "instance_type_qa_build" {
  default = "t2.micro"
}

variable "public_subnet_id" {
  description = "Public Subnet"
}


variable "subnet_id" {
  description = "Subnet in which it needs to be created"
}

variable "aws_ami_nginx" {
  description = "AMI name"
}

variable "aws_ami_capp" {
  description = "AMI Capp"
}

variable "aws_ami_eapp" {
  description = "EAPP AMI"
}

variable "aws_ami_worker" {
  description = "AMI of eworker node"
}

variable "aws_ami_bastion" {
  description = "Bastion AMI"
}

variable "aws_ami_qa_build" {
  description = "AMI QA build"
}

variable "aws_ami_redis" {
  description = " Redis AMI"
}


variable "aws_ami_pgbouncer" {
  description = "Pbgouncer AMI"
}

variable "aws_ami_docs" {
  description = "DOcs AMI"
}

variable "aws_ami_prometheous1" {
  description = "AMI prometheous"
}


variable "aws_ami_prometheous2" {
  description = "AMI prometheous"
}

variable "vpc_id" {
  description = "Name of the VPC"
}
