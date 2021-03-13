output "website-url" {
  value = var.custom_domain == "" ?  module.website.website : var.custom_domain
}

output "cdn-url" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "distribution-id" {
  value = aws_cloudfront_distribution.this.id
}
