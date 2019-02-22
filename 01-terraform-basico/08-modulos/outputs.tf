output "bucket_1" {
  value = "${module.bucket.name}"
}

output "bucket_1_object" {
  value = "${module.bucket.object}"
}

output "bucket_2" {
  value = "${module.bucket-2.name}"
}
