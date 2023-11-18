locals {
  account_id      = data.aws_caller_identity.current.account_id
  has_domain      = var.domain_name != null
  domain_name     = local.has_domain ? var.domain_name : random_pet.website.id
  regional_domain = "${local.domain_name}.s3.${var.aws_region}.amazonaws.com"


  common_tags = {
    "Project"    = "Curso AWS com Terraform"
    "Module"     = "Static Website"
    "CreateAt"   = "2023-11-15"
    "ManagedBy"  = "Terraform"
    "Owner"      = "Cleber Gasparoto"
    "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
  }
}
