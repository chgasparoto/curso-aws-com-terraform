data "template_file" "s3-public-policy" {
  template = file("policy.json")
  vars     = { bucket_name = local.domain }
}

module "logs" {
  source = "github.com/chgasparoto/terraform-s3-object-notification"

  name = "${local.domain}-logs"
  acl  = "log-delivery-write"

  force_destroy = var.custom_domain == ""
}

module "website" {
  depends_on = [null_resource.build_website]

  source = "github.com/chgasparoto/terraform-s3-object-notification"

  name          = local.domain
  acl           = "public-read"
  policy        = data.template_file.s3-public-policy.rendered
  force_destroy = var.custom_domain == ""

  versioning = {
    enabled = true
  }

  filepath = "${path.root}/../website/build"
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
  source = "github.com/chgasparoto/terraform-s3-object-notification"

  name          = "www.${local.domain}"
  acl           = "public-read"
  force_destroy = var.custom_domain == ""

  website = {
    redirect_all_requests_to = var.custom_domain != "" ? var.custom_domain : module.website.website
  }
}
