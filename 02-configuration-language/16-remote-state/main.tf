# https://developer.hashicorp.com/terraform/language/settings/backends/configuration
# https://developer.hashicorp.com/terraform/language/settings/backends/s3

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

  default_tags {
    tags = {
      Lesson      = "Remote State"
      ManagedBy   = "Terraform"
      Description = "Stores terraform remote state files"
      Owner       = "Cleber Gasparoto"
      CreatedAt   = "2023-10-16"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote_state" {
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_versioning" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "lock_table" {
  name         = "tflock-${aws_s3_bucket.remote_state.bucket}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "remote_state_bucket" {
  value = {
    arn  = aws_s3_bucket.remote_state.arn
    name = aws_s3_bucket.remote_state.bucket
  }
}

output "remote_state_lock_table" {
  value = {
    arn  = aws_dynamodb_table.lock_table.arn
    name = aws_dynamodb_table.lock_table.name
  }
}
