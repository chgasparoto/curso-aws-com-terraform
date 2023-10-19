# https://developer.hashicorp.com/terraform/language/values/outputs

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"

  default_tags {
    tags = {
      "CreateAt"   = "2023-10-01"
      "Module"     = "Configuration Language"
      "Component"  = "Outputs"
      "ManagedBy"  = "Terraform"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}

resource "random_pet" "bucket" {
  length = 6
}

resource "aws_s3_bucket" "random" {
  bucket = random_pet.bucket.id
}
