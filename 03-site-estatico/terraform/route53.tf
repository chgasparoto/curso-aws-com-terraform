data "aws_route53_zone" "this" {
  count = var.custom_domain != "" ? 1 : 0

  name = "${local.domain}."
}

resource "aws_route53_record" "website" {
  count = var.custom_domain != "" ? 1 : 0

  name    = local.domain
  type    = "A"
  zone_id = data.aws_route53_zone.this[0].zone_id

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  count = var.custom_domain != "" ? 1 : 0

  name    = "www.${local.domain}"
  type    = "A"
  zone_id = data.aws_route53_zone.this[0].zone_id

  alias {
    name                   = module.redirect.website_domain
    zone_id                = module.redirect.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cert_validation" {
  provider = aws.us-east-1

  for_each = length(aws_acm_certificate.cert) == 0 ? {} : {
    for dvo in aws_acm_certificate.cert[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this[0].zone_id
}
