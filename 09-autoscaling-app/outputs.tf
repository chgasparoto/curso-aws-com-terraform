output "vpc_id" {
  value = aws_vpc.this.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}

output "subnet_ids" {
  value = local.subnet_ids
}

output "route_table_public_id" {
  value = aws_route_table.public.id
}

output "route_table_private_id" {
  value = aws_route_table.private.id
}

output "alb_id" {
  value = aws_alb.this.id
}

output "alb_dns" {
  value = aws_alb.this.dns_name
}
