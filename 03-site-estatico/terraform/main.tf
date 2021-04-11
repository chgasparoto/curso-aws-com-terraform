terraform {
  required_version = "0.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.32.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile
  alias   = "us-east-1"
}

resource "random_pet" "website" {
  length = 5
}
