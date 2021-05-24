terraform {
  required_version = "0.15.4"

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

  backend "s3" {}
}

provider "aws" {
  region = var.aws_region

  //@link: https://www.hashicorp.com/blog/default-tags-in-the-terraform-aws-provider
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
