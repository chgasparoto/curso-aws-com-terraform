output "name" {
  value = aws_s3_bucket.this.id
}

output "domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

output "website" {
  value = aws_s3_bucket.this.website_endpoint
}

output "arn" {
  value = aws_s3_bucket.this.arn
}

output "files" {
  value = module.objects
}
