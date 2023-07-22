terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region  = "eu-central-1" # Brasil -> us-east-1
  profile = "custom_profile"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#private-bucket-w-tags
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-tf-test-bucket-123123455745642342342-fkjhadfuqewqkhadsf"
}
