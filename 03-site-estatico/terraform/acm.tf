resource "aws_acm_certificate" "cert" {
  count = var.custom_domain != "" ? 1 : 0

  provider = aws.us-east-1

  domain_name               = local.domain
  subject_alternative_names = ["*.${local.domain}"]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "example" {
  count = var.custom_domain != "" ? 1 : 0

  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.cert[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
