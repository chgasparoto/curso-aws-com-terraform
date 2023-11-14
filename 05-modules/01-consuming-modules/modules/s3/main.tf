resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

variable "bucket_name" {
  type        = string
  description = "The bucket name"
}

output "arn" {
  value = aws_s3_bucket.this.arn
}
