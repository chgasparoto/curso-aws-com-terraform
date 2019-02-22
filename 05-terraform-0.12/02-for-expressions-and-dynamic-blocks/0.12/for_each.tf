variable "subnet_numbers" {
  description = "Map from availability zone to the number that should be used for each availability zone's subnet"
  default     = {
    "eu-west-1a" = 1
    "eu-west-1b" = 2
    "eu-west-1c" = 3
  }
}

resource "aws_vpc" "example" {
  # ...
}

resource "aws_subnet" "example" {
  for_each = var.subnet_numbers

  vpc_id            = aws_vpc.example.id
  availability_zone = each.key
  cidr_block        = cidrsubnet(aws_vpc.example.cidr_block, 8, each.value)
}
