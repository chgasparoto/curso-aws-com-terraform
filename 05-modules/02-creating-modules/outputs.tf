output "arn" {
  value = aws_s3_bucket.this.arn
}

output "name" {
  value = aws_s3_bucket.this.id
}

output "regional_domain_name" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

output "website" {
  value = local.is_website_set ? aws_s3_bucket_website_configuration.this[0].website_endpoint : aws_s3_bucket.this.bucket_domain_name
}

output "website_domain" {
  value = local.is_website_set ? aws_s3_bucket_website_configuration.this[0].website_domain : aws_s3_bucket.this.bucket_domain_name
}

output "hosted_zone_id" {
  value = aws_s3_bucket.this.hosted_zone_id
}

output "objects" {
  value = [for filename, data in module.objects : filename]
}
