resource "aws_lb_target_group" "nginx_target_public" {
  name = "${var.env_name}-target-group-nginx"
  port = "${var.lister_port_http}"
  protocol = "${var.lister_nlb_protocol}"
  vpc_id = "${var.vpc_id}"
  stickiness {
    type = "lb_cookie"
    enabled = false
  }

}

resource "aws_lb_target_group_attachment" "nginx_target_group_attachment" {
  count = "${length(aws_instance.instance_nginx_reverse_proxy.*.id)}"
  target_group_arn = "${aws_lb_target_group.nginx_target_public.arn}"
  target_id        = "${element(aws_instance.instance_nginx_reverse_proxy.*.id, count.index)}"
  port             = "${var.lister_port_http}"
}

resource "aws_lb_target_group" "nginx_target_private" {
  name = "${var.env_name}-target-group-nginx-private"
  port = "${var.lister_port_http}"
  protocol = "${var.lister_nlb_protocol}"
  vpc_id = "${var.vpc_id}"
  stickiness {
    type = "lb_cookie"
    enabled = false
  }

}

resource "aws_lb_target_group_attachment" "nginx_target_group_attachment_private" {
  count = "${length(aws_instance.instance_nginx_reverse_proxy.*.id)}"
  target_group_arn = "${aws_lb_target_group.nginx_target_private.arn}"
  target_id        = "${element(aws_instance.instance_nginx_reverse_proxy.*.id, count.index)}"
  port             = "${var.lister_port_http}"
}

resource "aws_instance" "instance_nginx_reverse_proxy" {
      ami = "${var.aws_ami_nginx}"
      instance_type = "${var.instance_type_nginx}"
      count = 2
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_edge}"]
      subnet_id = "${element(var.public_subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-Nginx-${count.index}"
      }
      tags = {
        Name="${var.env_name}-Nginx-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_capp" {
      ami = "${var.aws_ami_capp}"
      instance_type = "${var.instance_type_capp}"
      count = 2
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_app}"]
      subnet_id = "${element(var.subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-capp-${count.index}"
      }
      tags = {
        Name="${var.env_name}-capp-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_eapp" {
      ami = "${var.aws_ami_eapp}"
      instance_type = "${var.instance_type_eapp}"
      count = 2
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_app}"]
      subnet_id = "${element(var.subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-eapp-${count.index}"
      }
      tags = {
        Name="${var.env_name}-eapp-${count.index}"
        Environment="${var.env_name}"

      }
}


resource "aws_instance" "instance_eworker" {
      ami = "${var.aws_ami_worker}"
      instance_type = "${var.instance_type_eworker}"
      count = 2
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_app}"]
      subnet_id = "${element(var.subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-eworker-${count.index}"
      }
      tags = {
        Name="${var.env_name}-eworker-${count.index}"
        Environment="${var.env_name}"

      }
}


resource "aws_instance" "instance_bastion" {
      ami = "${var.aws_ami_bastion}"
      instance_type = "${var.instance_type_bastion}"
      count = 1
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_bastion}"]
      subnet_id = "${element(var.public_subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size=50
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-bastion-${count.index}"
      }
      tags = {
        Name="${var.env_name}-bastion-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_QA_BUILD" {
      ami = "${var.aws_ami_qa_build}"
      instance_type = "${var.instance_type_qa_build}"
      count = 1
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_infra}"]
      subnet_id = "${element(var.subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-qa-build-${count.index}"
      }
      tags = {
        Name="${var.env_name}-qa-build-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_Redis" {
      ami = "${var.aws_ami_redis}"
      instance_type = "${var.instance_type_redis}"
      count = 3
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_app}"]
      subnet_id = "${element(var.subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-redis-${count.index}"
      }
      tags = {
        Name="${var.env_name}-redis-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_pgbouncer" {
      ami = "${var.aws_ami_pgbouncer}"
      instance_type = "${var.instance_type_pgbouncer}"
      count = 3
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_pgbouncer}"]
      subnet_id = "${element(var.subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size=20
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-pgbouncer-${count.index}"
      }
      tags = {
        Name="${var.env_name}-pgbouncer-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_docs" {
      ami = "${var.aws_ami_docs}"
      instance_type = "${var.instance_type_docs}"
      count = 1
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_infra}"]
      subnet_id = "${element(var.subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-docs-${count.index}"
      }
      tags = {
        Name="${var.env_name}-docs-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_prometheous1" {
      ami = "${var.aws_ami_prometheous1}"
      instance_type = "${var.instance_type_prometheous1}"
      count = 1
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_infra}"]
      subnet_id = "${element(var.public_subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-prometheous1-${count.index}"
      }
      tags = {
        Name="${var.env_name}-prometheous1-${count.index}"
        Environment="${var.env_name}"

      }
}

resource "aws_instance" "instance_prometheous2" {
      ami = "${var.aws_ami_prometheous2}"
      instance_type = "${var.instance_type_prometheous2}"
      count = 1
      key_name = "${var.key_name}"
      vpc_security_group_ids = ["${var.security_group_infra}"]
      subnet_id = "${element(var.public_subnet_id, count.index)}"
      root_block_device {
        volume_type="${var.volume_type}"
        volume_size="${var.volume_size}"
        delete_on_termination=false
        encrypted = true
      }
      volume_tags = {
        Name="${var.env_name}-prometheous2-${count.index}"
      }
      tags = {
        Name="${var.env_name}-prometheous2-${count.index}"
        Environment="${var.env_name}"

      }
}
