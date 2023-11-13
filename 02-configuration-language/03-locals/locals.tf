locals {
  namespaced_service_name = "${var.service_name}-${var.environment}"

  required_tags = {
    "Project"    = "Curso AWS com Terraform"
    "Module"     = "Configuration Language"
    "Component"  = "Locals"
    "CreatedAt"  = "2023-10-24"
    "ManagedBy"  = "Terraform"
    "Owner"      = "Cleber Gasparoto"
    "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
  }

  common_tags = merge(local.required_tags, var.tags)
}
