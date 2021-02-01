data "template_file" "s3-public-policy" {
  template = file("policy.json")
  vars     = { bucket_name = local.domain }
}

module "logs" {
  source = "../../02-terraform-intermediario/04-modules/s3_module"

  name = "${local.domain}-logs"
  acl  = "log-delivery-write"
}

module "website" {
  source = "../../02-terraform-intermediario/04-modules/s3_module"

  name   = local.domain
  acl    = "public-read"
  policy = data.template_file.s3-public-policy.rendered

  versioning = {
    enabled = true
  }

  files = "${path.root}/../website/build"
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
  source = "../../02-terraform-intermediario/04-modules/s3_module"

  name = "www.${local.domain}"
  acl  = "public-read"

  website = {
    redirect_all_requests_to = local.domain
  }
}
