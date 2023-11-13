terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-central-1"
  profile = "tf_macm1_ggasparoto"
}

resource "aws_s3_bucket" "example" {
  bucket = "o-bucket-do-cleber-criado-no-terraform-em-2023-01"

  tags = {
    CreatedAt = "2023-10-23"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}
