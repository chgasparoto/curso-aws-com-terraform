
output "file" {
  value = "${var.bucket}${aws_s3_bucket_object.this.key}"
}

output "object_etag" {
  value = aws_s3_bucket_object.this.etag
}

output "object_content_type" {
  value = aws_s3_bucket_object.this.content_type
}

output "object_meta" {
  value = aws_s3_bucket_object.this.metadata
}
