# https://developer.hashicorp.com/terraform/language/import

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"

  default_tags {
    tags = {
      "CreateAt"   = "2023-10-01"
      "Module"     = "Configuration Language"
      "Component"  = "Import Block"
      "ManagedBy"  = "Terraform"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}
