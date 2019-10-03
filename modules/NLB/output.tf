# output "aws_alb_target_group" {
#   value = "${aws_alb_target_group.example-target-external.id}"
# }
#
# output "aws_private_lb_target_group" {
#   value = "${aws_alb_target_group.example-target-internal.id}"
# }

output "aws_public_nlb" {
  value = "${aws_lb.public-network-lb.dns_name}"
}

output "aws_private_nlb" {
  value = "${aws_lb.private-network-lb.dns_name}"
}
