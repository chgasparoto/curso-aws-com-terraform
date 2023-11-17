provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Project"    = "Curso AWS com Terraform"
      "Module"     = "Serverless App"
      "CreateAt"   = "2023-11-16"
      "ManagedBy"  = "Terraform"
      "Owner"      = "Cleber Gasparoto"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}
