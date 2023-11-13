resource "aws_s3_bucket" "images" {
  bucket = "${replace(local.namespaced_service_name, "_", "-")}-images-123321"
}
