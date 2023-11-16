data "aws_caller_identity" "current" {}

data "aws_route53_zone" "this" {
  count = local.has_domain ? 1 : 0

  name = "${local.domain_name}."
}
