# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-12312312312"
  acl    = "private"

  tags = {
    Name        = "My super bucket"
    Environment = "Prod"
  }
}
