provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-12312312312"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
