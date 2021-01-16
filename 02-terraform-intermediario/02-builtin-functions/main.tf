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
  region  = lookup(var.aws_region, var.env)
  profile = "tf014"
}

resource "random_id" "bucket" {
  byte_length = 4
}
