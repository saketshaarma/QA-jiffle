resource "aws_lb" "public-network-lb" {
  name = "${var.env_name}-public"
  internal = false
  load_balancer_type = "network"
  subnets = "${flatten(var.vpc_subnet)}"
  tags = {
    Environment = "${var.env_name}"
  }
  enable_cross_zone_load_balancing = true
}

resource "aws_lb" "private-network-lb" {
  name = "${var.env_name}-private"
  internal = true
  load_balancer_type = "network"
  subnets = "${flatten(var.vpc_subnet)}"

  tags = {
    Environment = "${var.env_name}"
  }
  enable_cross_zone_load_balancing = true

}

resource "aws_alb_listener" "public-network-listner" {
  load_balancer_arn = "${aws_lb.public-network-lb.arn}"
  protocol = "${var.protocol_for_nlb_http_https}"
  port = "${var.port_http}"
  default_action {
    type = "forward"
    target_group_arn = "${var.nginx_target_group_public}"
  }
}

resource "aws_alb_listener" "private-network-listner" {
  load_balancer_arn = "${aws_lb.private-network-lb.arn}"
  protocol = "${var.protocol_for_nlb_http_https}"
  port = "${var.port_http}"
  default_action {
    type = "forward"
    target_group_arn = "${var.nginx_target_group_private}"
  }
}
