output "file" {
  value = "${var.bucket}${aws_s3_bucket_object.this.key}"
}
