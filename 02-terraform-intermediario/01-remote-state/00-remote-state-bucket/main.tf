terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
  }
}

provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = {
      Project   = "Curso AWS com Terraform"
      ManagedBy = "Terraform"
      Owner     = "Cleber Gasparoto"
      CreatedAt = "2023-09-06"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote_state" {
  bucket = "tfstate-2023-${data.aws_caller_identity.current.account_id}"

  tags = {
    Description = "Stores terraform remote state files"
  }
}

resource "aws_s3_bucket_versioning" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "lock_table" {
  name         = "tflock-${aws_s3_bucket.remote_state.bucket}"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "remote_state_bucket" {
  value = aws_s3_bucket.remote_state.bucket
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote_state.arn
}
