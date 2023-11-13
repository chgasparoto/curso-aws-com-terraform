# https://developer.hashicorp.com/terraform/language/expressions/for

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_macm1_ggasparoto"

  default_tags {
    tags = {
      "Project"    = "Curso AWS com Terraform"
      "Module"     = "Configuration Language"
      "Component"  = "for and splat expressions"
      "CreatedAt"  = "2023-11-12"
      "ManagedBy"  = "Terraform"
      "Owner"      = "Cleber Gasparoto"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}
