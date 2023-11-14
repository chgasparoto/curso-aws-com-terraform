
resource "aws_s3_bucket" "this" {
  bucket        = local.bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.ownership
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = local.is_public_access_set ? 1 : 0

  bucket = aws_s3_bucket.this.id

  block_public_acls       = lookup(var.public_access, "block_public_acls", true)
  block_public_policy     = lookup(var.public_access, "block_public_policy", true)
  ignore_public_acls      = lookup(var.public_access, "ignore_public_acls", true)
  restrict_public_buckets = lookup(var.public_access, "restrict_public_buckets", true)
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this
  ]

  bucket = aws_s3_bucket.this.bucket
  acl    = var.acl
}

resource "aws_s3_bucket_policy" "this" {
  count = var.policy != null ? 1 : 0

  depends_on = [
    aws_s3_bucket_acl.this,
  ]

  bucket = aws_s3_bucket.this.id
  policy = var.policy.json
}

resource "aws_s3_bucket_versioning" "this" {
  count = var.versioning.status != null ? 1 : 0

  bucket                = aws_s3_bucket.this.id
  expected_bucket_owner = lookup(var.versioning, "expected_bucket_owner", null)
  mfa                   = lookup(var.versioning, "mfa", null)

  versioning_configuration {
    status     = lookup(var.versioning, "status", null)
    mfa_delete = lookup(var.versioning, "mfa_delete", null)
  }
}

resource "aws_s3_bucket_logging" "this" {
  count = local.is_logging_set ? 1 : 0


  bucket        = aws_s3_bucket.this.id
  target_bucket = lookup(var.logging, "target_bucket", null)
  target_prefix = lookup(var.logging, "target_prefix", null)
}

resource "aws_s3_bucket_website_configuration" "this" {
  count = local.is_website_set ? 1 : 0

  bucket = aws_s3_bucket.this.id

  dynamic "index_document" {
    for_each = lookup(var.website, "index_document", null) == null ? [] : [var.website]

    content {
      suffix = index_document.value["index_document"]
    }
  }

  dynamic "error_document" {
    for_each = lookup(var.website, "error_document", null) == null ? [] : [var.website]
    content {
      key = error_document.value["error_document"]
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = lookup(var.website, "redirect_all_requests_to", null) == null ? [] : [var.website]
    content {
      host_name = redirect_all_requests_to.value["redirect_all_requests_to"]
    }
  }
}

module "objects" {
  source = "./modules/object"

  bucket     = aws_s3_bucket.this.bucket
  filepath   = var.filepath
  key_prefix = var.key_prefix
}
