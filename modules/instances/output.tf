output "nginx_target_public" {
  value = "${aws_lb_target_group.nginx_target_public.id}"
}

output "nginx_target_private" {
  value = "${aws_lb_target_group.nginx_target_private.id}"
}
