# https://developer.hashicorp.com/terraform/language/meta-arguments/resource-provider

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

provider "aws" {
  region  = "sa-east-1"
  profile = "tf_mac_air_m1_ggasparoto"

  alias = "sao_paulo"
}

resource "random_pet" "this" {
  length = 5
}

data "aws_caller_identity" "this" {}

resource "aws_s3_bucket" "frankfurt" {
  bucket = "${data.aws_caller_identity.this.account_id}-${random_pet.this.id}"
}

resource "aws_s3_bucket" "sao_paulo" {
  provider = aws.sao_paulo

  bucket = "${data.aws_caller_identity.this.account_id}-${random_pet.this.id}-sp"
}

output "bucket_name" {
  value = {
    frankfurt = aws_s3_bucket.frankfurt.bucket
    sao_paulo = aws_s3_bucket.sao_paulo.bucket
  }
}
