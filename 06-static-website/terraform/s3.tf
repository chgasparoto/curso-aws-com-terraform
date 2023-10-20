module "logs" {
  source = "github.com/chgasparoto/terraform-s3-object-notification?ref=v2.0.2"

  name          = "${local.domain}-logs"
  acl           = "log-delivery-write"
  force_destroy = true
}

module "website" {
  source  = "chgasparoto/object-notification/s3"
  version = "2.0.2"

  name          = local.domain
  acl           = local.bucket_website_acl
  policy        = local.bucket_policy
  force_destroy = !local.has_domain

  block_public_acls       = local.has_domain
  block_public_policy     = local.has_domain
  ignore_public_acls      = local.has_domain
  restrict_public_buckets = local.has_domain

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
  source  = "chgasparoto/object-notification/s3"
  version = "2.0.2"

  name          = "www.${local.domain}"
  acl           = local.bucket_website_acl
  force_destroy = !local.has_domain

  block_public_acls       = local.has_domain
  block_public_policy     = local.has_domain
  ignore_public_acls      = local.has_domain
  restrict_public_buckets = local.has_domain

  website = {
    redirect_all_requests_to = local.has_domain ? var.domain : module.website.website
  }
}
