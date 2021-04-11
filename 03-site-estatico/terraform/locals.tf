locals {
  has_domain       = var.domain != ""
  domain           = local.has_domain ? var.domain : random_pet.website.id
  regional_domain  = module.website.regional_domain_name
  website_filepath = "${path.module}/../website"

  common_tags = {
    Project   = "Curso AWS com Terraform"
    Service   = "Static Website"
    CreatedAt = "2020-03-14"
    Module    = "3"
  }
}
