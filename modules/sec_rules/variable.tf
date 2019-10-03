variable "http_port" {
  default = "80"
}
variable "https_port" {
  default = "443"
}

variable "ssh_port" {
  default = "22"
}

variable "internal_lb_port" {
  description = "Internal LB port"
  default = "15051"
}

variable "tcp_protocol" {
  default = "TCP"
}

variable "all_protocol" {
  default = "-1"
}

variable "all_from_port" {
  default = "0"
}

variable "from_port_icmp" {
  default = "-1"
}

variable "to_port_icmp" {
  default = "-1"
}

variable "all_to_port" {
  default = "0"
}

variable "public_accessibility" {
  default = "0.0.0.0/0"
}

variable "security_group_edge" {
  description = "Name of the security Group"
}

variable "security_group_app" {
  description = "Name of the security Group"
}
variable "security_group_bastion" {
  description = "Name of Bastion Security Group"
}

variable "pgrouncer_port" {
  default = "6432"
}

variable "pgsql_port" {
  default = "5432"
}

variable "rdp_port" {
  default = "3389"
}

variable "mysql_port" {
  default = "3306"
}

variable "jenkins_port" {
  default = "8080"
}

variable "custom_port" {
  default = "3000"
}
variable "security_group_infra" {
  description = "Infra sec group"
}

variable "security_group_pgbouncer" {
  description = "Secruity Group Name for Pgbouncer"
}

variable "security_group_pgSQL" {
  description = "Secruity Group Name for Pgbouncer"
}

variable "pgbouncer_port_user_list" {
  default = "8888"
}
