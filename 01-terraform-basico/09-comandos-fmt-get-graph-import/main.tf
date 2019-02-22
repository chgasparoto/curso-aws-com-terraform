provider "aws" {
  region = "${var.region}"
}

resource "random_id" "bucket" {
  byte_length = 8
}

resource "random_id" "bucket_2" {
  byte_length = 4
}

module "bucket" {
  source = "./s3"

  name       = "my-bucket-${random_id.bucket.hex}"
  versioning = true

  tags = {
    "Name" = "Meu bucket de anotações"
  }

  create_object = true
  object_key    = "files/${random_id.bucket.dec}.txt"
  object_source = "file.txt"
}

module "bucket-2" {
  source = "./s3"

  name = "my-bucket-${random_id.bucket_2.hex}"
}

resource "aws_s3_bucket" "meu_bucket" {
  bucket = "my-bucket-import-123456789"
  acl    = "private"
}
