output "name" {
  value = aws_s3_bucket.this.id
}

output "arn" {
  value = aws_s3_bucket.this.arn
}

output "website" {
  value = aws_s3_bucket.this.website_endpoint
}

output "regional_domain_name" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

output "website_domain" {
  value = aws_s3_bucket.this.website_domain
}

output "hosted_zone_id" {
  value = aws_s3_bucket.this.hosted_zone_id
}

output "files" {
  value = [for filename, data in module.objects : filename]
}
