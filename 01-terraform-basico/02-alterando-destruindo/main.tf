terraform {
  required_version = "~> 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = "eu-central-1" # Brasil -> us-east-1
}

# terraform validate
# terraform fmt
# terraform plan -out="tfplan.out"
# terraform destroy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#private-bucket-w-tags
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-tf-test-bucket-123123455745642342342"

  tags = {
    Name        = "My first Terraform bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Cleber Gasparoto"
    CreatedAt   = "2023-05-28"
  }
}
