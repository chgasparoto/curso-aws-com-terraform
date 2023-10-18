terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"
}

resource "random_pet" "bucket" {
  length = 6
}

resource "aws_s3_bucket" "random" {
  bucket = random_pet.bucket.id
}

output "pet_name" {
  value = random_pet.bucket.id
}

output "bucket_arn" {
  value       = aws_s3_bucket.random.arn
  description = "Bucket ARN"
  sensitive   = true
}

output "bucket_domain_name" {
  value = aws_s3_bucket.random.bucket_domain_name
}
