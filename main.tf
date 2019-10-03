provider "aws" {
    region = "${var.aws_region}"
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    version = "~> 2.30"
}

module "VPC" {
  source = "./modules/VPC"
  vpc_cidr_block = "${var.vpc_cidr_block}"
  env_name = "${var.env_name}"
}

module "security_group" {
  source = "./modules/security_group"
  env_name = "${var.env_name}"
  vpc_id = "${module.VPC.vpc_id}"
}

module "RDS" {
  source = "./modules/rds"
  security_group_database = "${module.security_group.QA-database}"
  subnet_id = "${module.VPC.private_subnet}"
  env_name = "${var.env_name}"
}

module "sec_rules" {
  source = "./modules/sec_rules"
  security_group_edge = "${module.security_group.QA-edge}"
  security_group_app = "${module.security_group.QA-app}"
  security_group_bastion = "${module.security_group.QA-bastion}"
  security_group_pgSQL = "${module.security_group.QA-database}"
  security_group_pgbouncer = "${module.security_group.QA-pgbouncer}"
  security_group_infra = "${module.security_group.QA-infra}"
}

module "NLB" {
  source = "./modules/NLB"
  nginx_target_group_public = "${module.instances.nginx_target_public}"
  nginx_target_group_private = "${module.instances.nginx_target_private}"
  env_name = "${var.env_name}"
  vpc_subnet = "${module.VPC.private_subnet}"
  vpc_id = "${module.VPC.vpc_id}"
}


module "instances" {
  source = "./modules/instances"
  security_group_edge = "${module.security_group.QA-edge}"
  security_group_app = "${module.security_group.QA-app}"
  security_group_bastion = "${module.security_group.QA-bastion}"
  security_group_infra = "${module.security_group.QA-infra}"
  security_group_pgbouncer = "${module.security_group.QA-pgbouncer}"
  aws_ami_prometheous2 = "${var.aws_ami_prometheous2}"
  aws_ami_prometheous1 = "${var.aws_ami_prometheous1}"
  aws_ami_docs = "${var.aws_ami_docs}"
  aws_ami_pgbouncer = "${var.aws_ami_pgbouncer}"
  aws_ami_redis = "${var.aws_ami_redis}"
  aws_ami_qa_build = "${var.aws_ami_qa_build}"
  aws_ami_bastion = "${var.aws_ami_bastion}"
  aws_ami_worker = "${var.aws_ami_worker}"
  aws_ami_eapp = "${var.aws_ami_eapp}"
  aws_ami_capp = "${var.aws_ami_capp}"
  aws_ami_nginx = "${var.aws_ami_nginx}"
  key_name="${var.key_name}"
  public_subnet_id = "${module.VPC.public_subnet}"
  subnet_id = "${module.VPC.private_subnet}"
  vpc_id = "${module.VPC.vpc_id}"
}
