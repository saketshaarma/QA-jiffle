resource "aws_db_subnet_group" "rds_sg" {
  subnet_ids = "${flatten(var.subnet_id)}"
}

resource "aws_db_instance" "default" {
  instance_class = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  storage_type         = "gp2"
  engine = "postgres"
  storage_encrypted=false
  engine_version = "${var.engine_version}"
  name = "${var.env_name}database"
  username = "${var.db_user_name}"
  password = "${var.db_user_password}"
  port = "${var.db_port}"
  backup_retention_period = "${var.backup_retention_period}"
  deletion_protection = false
  auto_minor_version_upgrade=false
  multi_az = true
  db_subnet_group_name = "${aws_db_subnet_group.rds_sg.id}"
  vpc_security_group_ids = ["${var.security_group_database}"]
  skip_final_snapshot = true
  tags = {
    Environment="${var.env_name}"
    Name = "${var.env_name}database"
  }
}
