# https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"

  default_tags {
    tags = {
      Lesson    = "Lifecycle"
      ManagedBy = "Terraform"
    }

  }
}

resource "random_pet" "this" {
  length = 5
}
