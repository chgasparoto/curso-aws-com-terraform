resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "Terraform ECS VPC "
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Terraform ECS IGW"
  }
}
