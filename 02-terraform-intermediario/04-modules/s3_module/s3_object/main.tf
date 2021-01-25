resource "aws_s3_bucket_object" "this" {
  bucket       = var.bucket
  key          = var.key
  source       = var.src
  etag         = filemd5(var.src)
  content_type = var.content_type
}
