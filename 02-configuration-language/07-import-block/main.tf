# https://developer.hashicorp.com/terraform/language/import

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"
}
