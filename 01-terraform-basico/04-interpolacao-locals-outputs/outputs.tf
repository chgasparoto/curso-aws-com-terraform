output "bucket_domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "ips_file_path" {
  value = aws_s3_bucket_object.this.key
}
