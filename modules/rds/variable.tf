variable "env_name" {
  description = "Environment you want to create"
}

variable "subnet_id" {
  description = "Subnet ID in which instance needs to be created"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "allocated_storage" {
  description = "storage size of the instance"
  default = "10"
}

variable "db_user_name" {
  default = "administrator"
}

variable "db_user_password" {
  default = "foobarbaz"
}

variable "backup_retention_period" {
  default = "0"
}

variable "engine_version" {
  default = "10.9"
}

variable "db_port" {
  default = "5342"
}

variable "security_group_database" {
  description = "Security Group for Database"
}
