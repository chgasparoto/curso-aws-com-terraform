resource "aws_s3_bucket" "this" {
  bucket = local.service_name
  tags   = local.common_tags
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object#uploading-a-file-to-a-bucket
resource "aws_s3_bucket_object" "this" {
  bucket = aws_s3_bucket.this.bucket
  key    = "config/ips.json"
  source = local.ip_filepath
  etag   = filemd5(local.ip_filepath)
}
