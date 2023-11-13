resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "Remote State"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "remote-state"
  }
}
