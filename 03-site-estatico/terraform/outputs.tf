output "website-url" {
  value = module.website.website
}

output "cdn-url" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "distribution-id" {
  value = aws_cloudfront_distribution.this.id
}
