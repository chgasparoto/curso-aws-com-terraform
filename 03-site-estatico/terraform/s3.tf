module "logs" {
  source = "github.com/chgasparoto/terraform-s3-object-notification?ref=v2.0.1"

  name          = "${local.domain}-logs"
  acl           = "log-delivery-write"
  force_destroy = !local.has_domain
  tags          = local.common_tags
}

module "website" {
  source = "github.com/chgasparoto/terraform-s3-object-notification?ref=v2.0.1"

  name          = local.domain
  acl           = "public-read"
  policy        = local.bucket_policy
  force_destroy = !local.has_domain
  tags          = local.common_tags

  versioning = {
    enabled = true
  }

  filepath = "${local.website_filepath}/dist"
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  logging = {
    target_bucket = module.logs.name
    target_prefix = "access/"
  }
}

module "redirect" {
  source = "github.com/chgasparoto/terraform-s3-object-notification?ref=v2.0.1"

  name          = "www.${local.domain}"
  acl           = "public-read"
  force_destroy = !local.has_domain
  tags          = local.common_tags

  website = {
    redirect_all_requests_to = local.has_domain ? var.domain : module.website.website
  }
}
