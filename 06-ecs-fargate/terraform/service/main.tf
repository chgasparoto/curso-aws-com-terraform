terraform {
  required_version = "1.0.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.55.0"
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

  //@link: https://www.hashicorp.com/blog/default-tags-in-the-terraform-aws-provider
  default_tags {
    tags = {
      Project   = "Curso AWS com Terraform"
      CreatedAt = "2020-08-22"
      ManagedBy = "Terraform"
      Owner     = "Cleber Gasparoto"
      Service   = "Auto Scaling App with ECS Fargate"
    }
  }
}
