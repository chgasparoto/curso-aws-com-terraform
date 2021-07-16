terraform {
  required_version = "1.0.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.47.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = "Curso AWS com Terraform"
      CreatedAt = "2020-05-24"
      ManagedBy = "Terraform"
      Owner     = "Cleber Gasparoto"
      Service   = "Auto Scaling App with ECS Fargate - ECR Repository"
    }
  }
}

resource "random_id" "version" {
  keepers = {
    server_file = local.file_hash
  }

  byte_length = 8
}
