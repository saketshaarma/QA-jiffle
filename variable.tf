variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  description = "Access Key for AWS authentication"
}

variable "aws_secret_key" {
  description = "Secret Key for AWS authentication"
}

variable "env_name" {
  description = "Name of the Environment"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
}

variable "instance_type" {
  description = "AMI name"
}

variable "key_name" {
  description = "Key Name"
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
