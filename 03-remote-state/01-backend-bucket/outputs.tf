output "remote_state_bucket" {
  value = {
    arn  = aws_s3_bucket.remote_state.arn
    name = aws_s3_bucket.remote_state.bucket
  }
}

output "remote_state_lock_table" {
  value = {
    arn  = aws_dynamodb_table.lock_table.arn
    name = aws_dynamodb_table.lock_table.name
  }
}
