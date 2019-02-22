output "remote_state_bucket_name" {
  value = "${module.bucket.name}"
}

output "remote_state_bucket_arn" {
  value = "${module.bucket.arn}"
}
