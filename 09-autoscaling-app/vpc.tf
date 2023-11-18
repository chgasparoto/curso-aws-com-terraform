resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

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
    "pub_a" = {
      cidr_block = "10.0.1.0/24"
      az         = "${var.aws_region}a"
      name       = "public-a"
    }
    "pub_b" = {
      cidr_block = "10.0.2.0/24"
      az         = "${var.aws_region}b"
      name       = "public-b"
    }
    "pvt_a" = {
      cidr_block = "10.0.3.0/24"
      az         = "${var.aws_region}a"
      name       = "private-a"
    }
    "pvt_b" = {
      cidr_block = "10.0.4.0/24"
      az         = "${var.aws_region}b"
      name       = "private-b"
    }
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["az"]

  tags = {
    Name = "${local.namespaced_service_name}-${each.value.name}"
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

  route_table_id = substr(each.key, 0, 3) == "pub" ? aws_route_table.public.id : aws_route_table.private.id
  subnet_id      = each.value
}
