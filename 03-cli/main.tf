# https://developer.hashicorp.com/terraform/cli

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      "CreateAt"   = "2023-10-01"
      "Module"     = "CLI"
      "ManagedBy"  = "Terraform"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}

resource "random_pet" "service_name" {
  length = 6
}
