# https://developer.hashicorp.com/terraform/language/modules

provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      "Project"    = "Curso AWS com Terraform"
      "Module"     = "Modules"
      "Component"  = "Consuming modules"
      "CreatedAt"  = "2023-11-12"
      "ManagedBy"  = "Terraform"
      "Owner"      = "Cleber Gasparoto"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}

resource "random_pet" "service_name" {
  length = 6
}
