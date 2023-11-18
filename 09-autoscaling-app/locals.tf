locals {
  namespaced_service_name = "${var.service_name}-${var.environment}"
  subnet_ids              = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  internet_cidr_block = "0.0.0.0/0"

  common_tags = {
    "Project"    = "Curso AWS com Terraform"
    "Module"     = "Auto Scaling App"
    "CreateAt"   = "2023-18-11"
    "ManagedBy"  = "Terraform"
    "Owner"      = "Cleber Gasparoto"
    "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
  }
}
