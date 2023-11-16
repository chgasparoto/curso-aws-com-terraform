output "website_url" {
  value = local.has_domain ? var.domain_name : aws_cloudfront_distribution.this.domain_name
}

output "bucket_arn" {
  value = module.website_bucket.arn
}

output "distribution_id" {
  value = aws_cloudfront_distribution.this.id
}
