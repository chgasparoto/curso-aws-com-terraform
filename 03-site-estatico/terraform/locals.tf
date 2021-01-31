locals {
  domain          = var.custom_domain != "" ? var.custom_domain : random_pet.website.id
  regional_domain = module.website.regional_domain_name

  common_tags = {
    Project   = "Static Website"
    CreatedAt = "2020-01-31"
    Module    = "3"
  }
}
