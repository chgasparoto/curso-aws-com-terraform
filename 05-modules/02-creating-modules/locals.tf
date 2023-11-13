locals {
  now         = timestamp()
  random_name = "terraform-${formatdate("DDMMYYYYhhmm", local.now)}"
  bucket_name = var.name != null ? var.name : local.random_name

  is_public_access_set = length([for k, v in var.public_access : v if v != null]) > 0
  is_website_set       = length([for k, v in var.website : v if v != null]) > 0
  is_logging_set       = length([for k, v in var.logging : v if v != null]) > 0
}
