output "vpc_id" {
  value = "${aws_vpc.example_vpc.id}"
}

output "private_subnet" {
  value = "${aws_subnet.private_subnet.*.id}"
}

output "public_subnet" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "nat_gateway_id" {
  value = "${aws_nat_gateway.nat_gw.*.id}"
}
