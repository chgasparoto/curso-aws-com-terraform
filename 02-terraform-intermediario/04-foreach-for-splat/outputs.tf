output "instance_arns" {
  value = [for k, v in aws_instance.this : v.arn]
}

output "instance_names" {
  value = { for k, v in aws_instance.this : k => v.tags.Name }
}

output "extensions" {
  value = local.file_extensions
}

output "extensions_uppercase" {
  value = local.file_extension_caps
}

output "public_ips" {
  value = local.ips_public
}

output "private_ips" {
  value = [for i in local.ips : i.private]
}
