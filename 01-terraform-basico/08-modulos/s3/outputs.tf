output "name" {
  value = "${aws_s3_bucket.this.id}"
}

output "arn" {
  value = "${aws_s3_bucket.this.arn}"
}

output "object" {
  value = "${aws_s3_bucket_object.this.*.key}"
}
