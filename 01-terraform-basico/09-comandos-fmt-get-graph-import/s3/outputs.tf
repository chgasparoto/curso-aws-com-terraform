output "name" {
  value = "${aws_s3_bucket.this.id}"
}

output "object" {
  value = "${aws_s3_bucket_object.this.*.key}"
}
