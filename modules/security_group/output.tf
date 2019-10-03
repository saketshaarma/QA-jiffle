output "QA-app" {
  value = "${aws_security_group.QA-app.id}"
}

output "QA-bastion" {
  value = "${aws_security_group.QA-bastion.id}"
}

output "QA-database" {
  value = "${aws_security_group.QA-database.id}"
}

output "QA-pgbouncer" {
  value = "${aws_security_group.QA-pgbouncer.id}"
}

output "QA-edge" {
  value = "${aws_security_group.QA-edge.id}"
}

output "QA-infra" {
  value = "${aws_security_group.QA-infra.id}"
}
