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
  profile = "tf014"
}

resource "random_id" "bucket" {
  byte_length = 8
}

resource "random_id" "bucket-2" {
  byte_length = 4
}

module "bucket" {
  source     = "./s3-module"
  name       = "my-bucket-${random_id.bucket.hex}"
  versioning = true

  create_object = true
  object_key    = "files/${random_id.bucket.dec}.txt"
  object_source = "file.txt"

  tags = {
    "Name" = "Meu bucket de anotações"
  }
}

module "bucket-2" {
  source = "./s3-module"
  name   = "my-bucket-${random_id.bucket-2.hex}"
}
