output "bucket" {
  value = {
    name                 = aws_s3_bucket.bucket.id
    arn                  = aws_s3_bucket.bucket.arn
    regional_domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    domain_name          = aws_s3_bucket.bucket.bucket_domain_name
  }
}
