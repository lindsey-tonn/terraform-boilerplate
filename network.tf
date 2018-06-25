resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"

  #### this 2 true values are for use the internal vpc dns resolution
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "VPC_Terraform"
  }
}

resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.main.id}"

  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Private"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.main.id}"

  cidr_block              = "${var.public_subnet_cidr}"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags {
    Name = "Public"
  }
}

# IGW for the public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

# Create a NAT gateway with an EIP for each private subnet to get internet connectivity
resource "aws_eip" "gw" {
  vpc        = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "gw" {
  subnet_id     = "${aws_subnet.public.id}"
  allocation_id = "${aws_eip.gw.id}"
}

# Create a new route table for the private subnets
# And make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }
}

# Explicitely associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}
