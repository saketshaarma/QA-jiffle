resource "aws_security_group" "QA-app" {
  name = "${var.env_name}-capp-sec-rules"
  description = "Sec rules for CAPP instances"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "QA-bastion" {
  name = "${var.env_name}-bastion-sec-rules"
  description = "Sec rules for bastion instances"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "QA-database" {
  name = "${var.env_name}-database-sec-rules"
  description = "Sec rules for database instances"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "QA-pgbouncer" {
  name = "${var.env_name}-pgbouncer-sec-rules"
  description = "Sec rules for database instances"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "QA-edge" {
  name = "${var.env_name}-edge-sec-rules"
  description = "Sec rules for Nginx reverse proxy instances"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group" "QA-infra" {
  name = "${var.env_name}-infra-sec-rules"
  description = "Sec rules for CAPP instances"
  vpc_id = "${var.vpc_id}"

}
