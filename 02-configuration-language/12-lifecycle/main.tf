# https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_macm1_ggasparoto"

  default_tags {
    tags = {
      "Project"    = "Curso AWS com Terraform"
      "Module"     = "Configuration Language"
      "Component"  = "Meta-Argument: Lifecycle"
      "CreatedAt"  = "2023-10-25"
      "ManagedBy"  = "Terraform"
      "Owner"      = "Cleber Gasparoto"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}

resource "random_pet" "this" {
  length = 5
}
