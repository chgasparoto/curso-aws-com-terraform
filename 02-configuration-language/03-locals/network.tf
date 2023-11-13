resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = local.namespaced_service_name
  }
}
