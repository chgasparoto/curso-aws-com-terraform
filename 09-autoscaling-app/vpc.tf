resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = local.namespaced_service_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = local.namespaced_service_name
  }
}

resource "aws_subnet" "this" {
  for_each = {
    "pub_a" : ["192.168.1.0/24", "${var.aws_region}a", "public-a"]
    "pub_b" : ["192.168.2.0/24", "${var.aws_region}b", "public-b"]
    "pvt_a" : ["192.168.3.0/24", "${var.aws_region}a", "private-a"]
    "pvt_b" : ["192.168.4.0/24", "${var.aws_region}b", "private-b"]
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = {
    Name = "${local.namespaced_service_name}-${each.value[2]}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${local.namespaced_service_name}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${local.namespaced_service_name}-private"
  }
}

resource "aws_route_table_association" "this" {
  for_each = local.subnet_ids

  subnet_id      = each.value
  route_table_id = substr(each.key, 0, 3) == "Pub" ? aws_route_table.public.id : aws_route_table.private.id
}
