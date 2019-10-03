resource "aws_vpc" "example_vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  instance_tenancy = "${var.instance_tenancy}"
  enable_dns_support = "${var.dns_support_for_vpc}"
  tags = {
    Name = "${var.env_name}-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block,8,count.index )}"
  vpc_id = "${aws_vpc.example_vpc.id}"
  map_public_ip_on_launch = false
  tags = {
    Name="${var.env_name}-public_subnet"
  }

}

resource "aws_subnet" "private_subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block = "${cidrsubnet(var.vpc_cidr_block,8,length(data.aws_availability_zones.available.id)+count.index)}"
  vpc_id = "${aws_vpc.example_vpc.id}"
  map_public_ip_on_launch = false
  tags = {
    Name="${var.env_name}-private_subnet"
  }

}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = "${aws_vpc.example_vpc.id}"
  tags = {
    Name="${var.env_name}-igw"
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = "${aws_vpc.example_vpc.id}"
  route {
    cidr_block = "${var.cidr_public}"
    gateway_id = "${aws_internet_gateway.example_igw.id}"
  }

  tags = {
    Name="${var.env_name}-public_route_table"
  }
}

resource "aws_route_table" "route_table_private" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.example_vpc.id}"
  route {
    cidr_block = "${var.cidr_public}"
    nat_gateway_id = "${element(aws_nat_gateway.nat_gw.*.id, count.index)}"
  }

  tags = {
    Name="${var.env_name}-private_route_table"
  }
}

resource "aws_eip" "eip_ng" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc = true
}
resource "aws_nat_gateway" "nat_gw" {
  count = "${length(data.aws_availability_zones.available.names)}"
  allocation_id = "${element(aws_eip.eip_ng.*.id,count.index )}"
  subnet_id = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  depends_on = ["aws_internet_gateway.example_igw"]
}
resource "aws_route_table_association" "route_ass_private" {
  count = "${length(data.aws_availability_zones.available.names)}"
  route_table_id = "${aws_route_table.route_table_private[count.index].id}"
  subnet_id = "${element(aws_subnet.private_subnet.*.id,count.index )}"
}

resource "aws_route_table_association" "rt_public_association" {
  count = "${length(data.aws_availability_zones.available.names)}"
  route_table_id = "${aws_route_table.route_table_public.id}"
  subnet_id = "${element(aws_subnet.public_subnet.*.id,count.index )}"
}
