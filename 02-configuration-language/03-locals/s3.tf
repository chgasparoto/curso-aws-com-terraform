resource "aws_s3_bucket" "images" {
  bucket = "${local.namespaced_service_name}-images-123454321"
}
