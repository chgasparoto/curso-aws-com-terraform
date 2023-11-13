locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  common_tags = {
    "Project"    = "Curso AWS com Terraform"
    "Module"     = "Auto Scaling App"
    "CreateAt"   = "2023-10-01"
    "ManagedBy"  = "Terraform"
    "Owner"      = "Cleber Gasparoto"
    "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
  }
}
