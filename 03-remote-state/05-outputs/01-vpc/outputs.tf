output "vpc" {
  value = {
    id         = aws_vpc.this.id
    arn        = aws_vpc.this.arn
    cidr_block = aws_vpc.this.cidr_block
  }
}

output "subnet" {
  value = {
    id         = aws_subnet.example.id
    arn        = aws_subnet.example.arn
    cidr_block = aws_subnet.example.cidr_block
  }
}
