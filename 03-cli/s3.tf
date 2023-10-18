resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name != null ? var.bucket_name : random_pet.service_name.id
}
