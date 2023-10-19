locals {
  account_id = data.aws_caller_identity.this.account_id
  user_id    = data.aws_caller_identity.this.user_id

  # bucket_arn = data.aws_s3_bucket.logs.arn
}
