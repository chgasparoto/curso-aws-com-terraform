resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "${local.namespaced_service_name}-vpc"
  })
}
