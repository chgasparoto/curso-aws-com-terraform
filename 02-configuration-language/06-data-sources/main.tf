# https://developer.hashicorp.com/terraform/language/data-sources

# Data sources allow Terraform to use information defined
# outside of Terraform, defined by another separate
# Terraform configuration, or modified by functions.

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

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "this" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket
# data "aws_s3_bucket" "logs" {
#   bucket = "${local.account_id}-nome-do-bucket-dentro-do-console-da-aws"
# }

locals {
  account_id = data.aws_caller_identity.this.account_id
  user_id    = data.aws_caller_identity.this.user_id

  # bucket_arn = data.aws_s3_bucket.logs.arn
}

output "locals" {
  value = {
    account_id = local.account_id
    user_id    = local.user_id
    # bucket_arn = local.bucket_arn
  }
}
