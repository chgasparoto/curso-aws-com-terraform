output "remote_state_bucket_name" {
  value = "${aws_s3_bucket.state.bucket}"
}

output "remote_state_table_name" {
  value = "${aws_dynamodb_table.locking.name}"
}
