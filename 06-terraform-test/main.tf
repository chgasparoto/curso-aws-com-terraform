# https://www.hashicorp.com/blog/terraform-1-6-adds-a-test-framework-for-enhanced-code-validation
# https://developer.hashicorp.com/terraform/language/tests
# https://developer.hashicorp.com/terraform/cli/test
# https://developer.hashicorp.com/terraform/tutorials/configuration-language/test

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Project"    = "Curso AWS com Terraform"
      "Module"     = "Terraform Test"
      "CreatedAt"  = "2023-11-12"
      "ManagedBy"  = "Terraform"
      "Owner"      = "Cleber Gasparoto"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}
