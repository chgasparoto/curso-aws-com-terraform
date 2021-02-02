resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "Terraform VPC"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Terraform IGW"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.0.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Public 1a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Public 1b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Private 1a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Private 1b"
  }
}

resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Terraform public"
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Terraform private"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_private.id
}

