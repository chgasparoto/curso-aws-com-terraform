data "template_file" "s3-public-policy" {
  template = file("policy.json")
  vars     = { bucket_name = local.domain }
}
