output "instace_arns" {
  value = [for server, attr in aws_instance.example : attr.arn]
}

output "instance_name" {
  value = { for server, attr in aws_instance.example : server => attr.tags.Name }
}

output "extensions" {
  value = local.file_extensions
}

output "extensions_upper" {
  value = local.file_extensions_upper
}

output "private_ips" {
  value = [for ip in local.ips : ip.private]
}

output "public_ips" {
  value = local.ips[*].public
}
