### AWS Rules for Nginx Reverse Proxy #####

resource "aws_security_group_rule" "ingress_http_edge" {
    type = "ingress"
      from_port = "${var.http_port}"
      to_port = "${var.http_port}"
      protocol = "${var.tcp_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
      description = "Port Whitelisting for http from outside world"
    security_group_id="${var.security_group_edge}"
}

resource "aws_security_group_rule" "ingress_https_edge" {
    type = "ingress"
      from_port = "${var.https_port}"
      to_port = "${var.https_port}"
      protocol = "${var.tcp_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
      description = "Port Whitelisting for https from outside world"
    security_group_id="${var.security_group_edge}"
}

resource "aws_security_group_rule" "ingress_ssh_edge" {
    type = "ingress"
      from_port = "${var.ssh_port}"
      to_port = "${var.ssh_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for SSH from Bastion"
    security_group_id="${var.security_group_edge}"
}

resource "aws_security_group_rule" "ingress_custom_edge" {
    type = "ingress"
      from_port = "${var.internal_lb_port}"
      to_port = "${var.internal_lb_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_app}"
      description = "Port Whitelisting for internal custom port from app"
    security_group_id="${var.security_group_edge}"
}

resource "aws_security_group_rule" "ingress_tracert_app" {
    type = "ingress"
      from_port = "${var.from_port_icmp}"
      to_port = "${var.to_port_icmp}"
      protocol = "icmp"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for tracepath diagnosis from Bastion"
    security_group_id="${var.security_group_edge}"
}

resource "aws_security_group_rule" "edge_outbound" {
    type = "egress"
      from_port = "${var.all_from_port}"
      to_port = "${var.all_to_port}"
      protocol = "${var.all_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
    security_group_id="${var.security_group_edge}"
}

### AWS Sec Rules for Capp/Eapp Nodes#####

resource "aws_security_group_rule" "ingress_http_app" {
    type = "ingress"
      from_port = "${var.http_port}"
      to_port = "${var.http_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_edge}"
      description = "Port Whitelisting for http from Nginx Reverse Proxy"
    security_group_id="${var.security_group_app}"
}

resource "aws_security_group_rule" "ingress_ssh_app_bastion" {
    type = "ingress"
      from_port = "${var.ssh_port}"
      to_port = "${var.ssh_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for SSH from Bastion"
    security_group_id="${var.security_group_app}"
}

resource "aws_security_group_rule" "ingress_ssh_app_infra" {
    type = "ingress"
      from_port = "${var.ssh_port}"
      to_port = "${var.ssh_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_infra}"
      description = "Port Whitelisting for SSH from Infra"
    security_group_id="${var.security_group_app}"
}

resource "aws_security_group_rule" "ingress_tracert_bastion" {
    type = "ingress"
      from_port = "${var.from_port_icmp}"
      to_port = "${var.to_port_icmp}"
      protocol = "icmp"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for tracepath diagnosis from Bastion"
    security_group_id="${var.security_group_bastion}"
}

resource "aws_security_group_rule" "app_outbound" {
    type = "egress"
      from_port = "${var.all_from_port}"
      to_port = "${var.all_to_port}"
      protocol = "${var.all_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
    security_group_id="${var.security_group_app}"
}

### AWS Sec Rules for PG Bouncer #####

resource "aws_security_group_rule" "ingress_pgbouncer" {
    type = "ingress"
      from_port = "${var.pgrouncer_port}"
      to_port = "${var.pgrouncer_port}"
      protocol = "${var.tcp_protocol}"
    source_security_group_id="${var.security_group_app}"
    description = "Port Whitelisting on PG bouncer from Apps"
    security_group_id="${var.security_group_pgbouncer}"
}

resource "aws_security_group_rule" "ingress_pgbouncer_user_list" {
    type = "ingress"
      from_port = "${var.pgbouncer_port_user_list}"
      to_port = "${var.pgbouncer_port_user_list}"
      protocol = "${var.tcp_protocol}"
    source_security_group_id = "${var.security_group_bastion}"
    description = "Port Whitelisting for User List from Bastion"
    security_group_id="${var.security_group_pgbouncer}"
}


resource "aws_security_group_rule" "ingress_ssh_pgbouncer" {
    type = "ingress"
      from_port = "${var.ssh_port}"
      to_port = "${var.ssh_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for SSH from Bastion"
    security_group_id="${var.security_group_pgbouncer}"
}
resource "aws_security_group_rule" "ingress_ssh_pgbouncer_infra" {
    type = "ingress"
      from_port = "${var.ssh_port}"
      to_port = "${var.ssh_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_infra}"
      description = "Port Whitelisting for Ansible connection"
    security_group_id="${var.security_group_pgbouncer}"
}

resource "aws_security_group_rule" "ingress_tracert_pgbouncer" {
    type = "ingress"
      from_port = "${var.from_port_icmp}"
      to_port = "${var.to_port_icmp}"
      protocol = "icmp"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for tracepath diagnosis from Bastion"
    security_group_id="${var.security_group_app}"
}

resource "aws_security_group_rule" "pgbouncer_outbound" {
    type = "egress"
      from_port = "${var.all_from_port}"
      to_port = "${var.all_to_port}"
      protocol = "${var.all_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
      security_group_id="${var.security_group_pgbouncer}"
}

### AWS Sec Rules for Database#####

resource "aws_security_group_rule" "ingress_pgSQL" {
    type = "ingress"
      from_port = "${var.pgsql_port}"
      to_port = "${var.pgsql_port}"
      protocol = "${var.tcp_protocol}"
    description = "Port Whitelisting for RDS from pgbouncer port"
    source_security_group_id="${var.security_group_pgbouncer}"
    security_group_id="${var.security_group_pgSQL}"
}

resource "aws_security_group_rule" "ingress_MySQL" {
    type = "ingress"
      from_port = "${var.mysql_port}"
      to_port = "${var.mysql_port}"
      protocol = "${var.tcp_protocol}"
    description = "Port Whitelisting for Mysql port"
    source_security_group_id="${var.security_group_app}"
    security_group_id="${var.security_group_pgSQL}"
}

resource "aws_security_group_rule" "pgSQL_outbound" {
    type = "egress"
      from_port = "${var.all_from_port}"
      to_port = "${var.all_to_port}"
      protocol = "${var.all_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
      security_group_id="${var.security_group_pgSQL}"
}

### AWS Bastion Sec rules ####

resource "aws_security_group_rule" "ingress_bastion_ssh" {
    type = "ingress"
      from_port = "${var.ssh_port}"
      to_port = "${var.ssh_port}"
      protocol = "${var.tcp_protocol}"
    description = "Port Whitelisting for ssh on Bastion"
    cidr_blocks = ["${var.public_accessibility}"]
    security_group_id="${var.security_group_bastion}"
}

resource "aws_security_group_rule" "ingress_bastion_rdp" {
    type = "ingress"
      from_port = "${var.rdp_port}"
      to_port = "${var.rdp_port}"
      protocol = "${var.tcp_protocol}"
    description = "Port Whitelisting for RDP through ssh tunneling"
    cidr_blocks = ["${var.public_accessibility}"]
    security_group_id="${var.security_group_bastion}"
}

resource "aws_security_group_rule" "bastion_outbound" {
    type = "egress"
      from_port = "${var.all_from_port}"
      to_port = "${var.all_to_port}"
      protocol = "${var.all_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
      security_group_id="${var.security_group_bastion}"
}

#### Security Group infra #####

resource "aws_security_group_rule" "ingress_http_infra" {
    type = "ingress"
      from_port = "${var.http_port}"
      to_port = "${var.http_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_edge}"
      description = "Port Whitelisting for http from edge"
    security_group_id="${var.security_group_infra}"
}

resource "aws_security_group_rule" "ingress_https_infra" {
    type = "ingress"
      from_port = "${var.https_port}"
      to_port = "${var.https_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_edge}"
      description = "Port Whitelisting for https from edge"
    security_group_id="${var.security_group_infra}"
}

resource "aws_security_group_rule" "ingress_ssh_infra" {
    type = "ingress"
      from_port = "${var.ssh_port}"
      to_port = "${var.ssh_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for SSH from Bastion"
    security_group_id="${var.security_group_infra}"
}

resource "aws_security_group_rule" "ingress_jenkins_infra" {
    type = "ingress"
      from_port = "${var.jenkins_port}"
      to_port = "${var.jenkins_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_edge}"
      description = "Port Whitelisting for jenkins from Nginx"
    security_group_id="${var.security_group_infra}"
}

resource "aws_security_group_rule" "ingress_custom_infra" {
    type = "ingress"
      from_port = "${var.custom_port}"
      to_port = "${var.custom_port}"
      protocol = "${var.tcp_protocol}"
      source_security_group_id="${var.security_group_edge}"
      description = "Port Whitelisting for custom port from Nginx"
    security_group_id="${var.security_group_infra}"
}

resource "aws_security_group_rule" "ingress_tracert_infra" {
    type = "ingress"
      from_port = "${var.from_port_icmp}"
      to_port = "${var.to_port_icmp}"
      protocol = "icmp"
      source_security_group_id="${var.security_group_bastion}"
      description = "Port Whitelisting for tracepath diagnosis from Bastion"
    security_group_id="${var.security_group_infra}"
}

resource "aws_security_group_rule" "infra_outbound" {
    type = "egress"
      from_port = "${var.all_from_port}"
      to_port = "${var.all_to_port}"
      protocol = "${var.all_protocol}"
      cidr_blocks = ["${var.public_accessibility}"]
      security_group_id="${var.security_group_infra}"
}
