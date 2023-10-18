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
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      "CreateAt"  = "2023-10-01"
      "ManagedBy" = "Terraform"
      "Module"    = "CLI"
    }
  }
}

resource "random_pet" "service_name" {
  length = 6
}
