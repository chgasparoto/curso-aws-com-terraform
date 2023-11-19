locals {
  namespaced_service_name = "${var.service_name}-${var.environment}"

  subnet_ids          = { for k, v in aws_subnet.this : v.tags.Name => v.id }
  internet_cidr_block = "0.0.0.0/0"
}
