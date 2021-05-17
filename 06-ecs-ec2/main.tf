terraform {
  required_version = "0.15.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  default_tags {
    tags = {
      Project   = "Curso AWS com Terraform"
      CreatedAt = "2020-05-17"
      ManagedBy = "Terraform"
      Owner     = "Cleber Gasparoto"
      Service   = "Auto Scaling App with ECS EC2"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
