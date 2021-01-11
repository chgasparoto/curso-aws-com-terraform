terraform {
  required_version = "0.14.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "tf013"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "meu-bucket-000111222333444555"

  tags = {
    Owner       = "Cleber Gasparoto"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
