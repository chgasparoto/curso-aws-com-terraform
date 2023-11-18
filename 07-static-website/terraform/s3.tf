module "website_bucket" {
  source  = "chgasparoto/s3-object/aws"
  version = "1.0.0"

  name     = local.domain_name
  filepath = "${path.module}/../website/dist"
}

resource "aws_s3_bucket_policy" "this" {
  bucket = module.website_bucket.name
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "PolicyForCloudFrontPrivateContent",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipal",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com"
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${local.domain_name}/*",
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceArn" : "arn:aws:cloudfront::${local.account_id}:distribution/${aws_cloudfront_distribution.this.id}"
          }
        }
      }
    ]
  })
}

module "logs_bucket" {
  source  = "chgasparoto/s3-object/aws"
  version = "1.0.0"

  name = "logs.${local.domain_name}"
  acl  = "log-delivery-write"
}
