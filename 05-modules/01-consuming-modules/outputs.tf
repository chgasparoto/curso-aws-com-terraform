output "bucket_name" {
  value = module.s3.s3_bucket_id
}

output "bucket_name_local" {
  value = module.s3_local.name
}
