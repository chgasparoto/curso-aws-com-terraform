# https://www.hashicorp.com/blog/terraform-1-6-adds-a-test-framework-for-enhanced-code-validation
# https://developer.hashicorp.com/terraform/language/tests
# https://developer.hashicorp.com/terraform/cli/test
# https://developer.hashicorp.com/terraform/tutorials/configuration-language/test
# http://terraform-test-intro-09877890.s3-website.eu-central-1.amazonaws.com/index.html

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.19"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Video"     = "Terraform Test"
      "CreatedAt" = "2023-10-08"
    }
  }
}
