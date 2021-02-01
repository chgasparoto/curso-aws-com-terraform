data "aws_route53_zone" "this" {
  name = "${local.domain}."
}

resource "aws_route53_record" "website" {
  name    = local.domain
  type    = "A"
  zone_id = data.aws_route53_zone.this.zone_id

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  name    = "www.${local.domain}"
  type    = "A"
  zone_id = data.aws_route53_zone.this.zone_id

  alias {
    name                   = module.redirect.website_domain
    zone_id                = module.redirect.hosted_zone_id
    evaluate_target_health = false
  }
}
