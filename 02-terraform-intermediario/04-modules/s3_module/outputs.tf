output "name" {
  value = aws_s3_bucket.this.id
}

output "arn" {
  value = aws_s3_bucket.this.arn
}

output "website" {
  value = aws_s3_bucket.this.website_endpoint
}

output "files" {
  value = module.objects
}
