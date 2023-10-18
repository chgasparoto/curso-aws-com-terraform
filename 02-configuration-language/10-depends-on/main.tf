# https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on

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

resource "random_pet" "this" {
  length = 5
}

data "aws_caller_identity" "this" {}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "${data.aws_caller_identity.this.account_id}-${random_pet.this.id}"
}

resource "aws_iam_user" "example_user" {
  name = "example-user"
}

resource "aws_iam_user_policy_attachment" "example_user_attachment" {
  user       = aws_iam_user.example_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

  depends_on = [aws_s3_bucket.example_bucket]
}

output "bucket_name" {
  value = aws_s3_bucket.example_bucket.bucket
}
