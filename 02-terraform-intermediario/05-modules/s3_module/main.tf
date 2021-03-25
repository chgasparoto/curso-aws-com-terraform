resource "aws_s3_bucket" "this" {
  bucket = var.name
  acl    = var.acl
  policy = var.policy
  tags   = var.tags

  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]
    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }

  dynamic "versioning" {
    for_each = length(keys(var.versioning)) == 0 ? [] : [var.versioning]
    content {
      enabled    = lookup(versioning.value, "enabled", null)
      mfa_delete = lookup(versioning.value, "mfa_delete", null)
    }
  }
}

module "objects" {
  source = "./s3_object"

  for_each = var.files != "" ? fileset(var.files, "**") : []

  bucket = aws_s3_bucket.this.bucket
  key    = "${var.key_prefix}/${each.value}"
  src    = "${var.files}/${each.value}"
}
