module "s3_static_website" {
  source = "../02-creating-modules"

  name = "terraform-${random_pet.this.id}"
  acl  = "public-read"
  policy = {
    json = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid       = "PublicReadGetObject"
          Effect    = "Allow"
          Principal = "*"
          Action    = "s3:GetObject"
          Resource = [
            "arn:aws:s3:::terraform-${random_pet.this.id}/*",
          ]
        },
      ]
    })
  }

  public_access = {
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
  }

  versioning = {
    status = "Enabled"
  }

  filepath = "./website"

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
}
