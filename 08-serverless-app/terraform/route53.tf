data "aws_route53_zone" "apex_domain" {
  count = local.create_resource_based_on_domain_name

  name         = var.domain_name
  private_zone = false
}

resource "aws_acm_certificate" "api" {
  count = local.create_resource_based_on_domain_name

  domain_name       = "api.${var.domain_name}"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "api" {
  count = local.create_resource_based_on_domain_name

  certificate_arn         = aws_acm_certificate.api[0].arn
  validation_record_fqdns = [for record in aws_route53_record.api_validation : record.fqdn]
}

resource "aws_route53_record" "api_validation" {
  for_each = local.has_domain_name ? {
    for dvo in aws_acm_certificate.api[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.apex_domain[0].zone_id
}

resource "aws_route53_record" "api" {
  count = local.create_resource_based_on_domain_name

  name    = aws_api_gateway_domain_name.this[0].domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.apex_domain[0].zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.this[0].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.this[0].regional_zone_id
  }
}
