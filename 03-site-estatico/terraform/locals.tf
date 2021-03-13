locals {
  domain          = var.custom_domain != "" ? var.custom_domain : random_pet.website.id
  regional_domain = module.website.regional_domain_name

  website_filepath = "${path.module}/../website/src"

  common_tags = {
    Project   = "Curso AWS com Terraform"
    Service   = "Static Website"
    CreatedAt = "2020-03-13"
    Module    = "3"
  }
}
