locals {
  has_domain       = var.domain != ""
  domain           = local.has_domain ? var.domain : random_pet.website.id
  regional_domain  = module.website.regional_domain_name
  website_filepath = "${path.module}/../website"

  bucket_policy = {
    json = jsonencode(
      {
        "Version" : "2008-10-17",
        "Statement" : [
          {
            "Sid" : "PublicReadForGetBucketObjects",
            "Effect" : "Allow",
            "Principal" : {
              "AWS" : "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.this.id}"
            },
            "Action" : "s3:GetObject",
            "Resource" : "arn:aws:s3:::${local.domain}/*"
          }
        ]
      }
    )
  }

  common_tags = {
    Project   = "Curso AWS com Terraform"
    Service   = "Static Website"
    CreatedAt = "2020-03-14"
    Module    = "3"
  }
}
