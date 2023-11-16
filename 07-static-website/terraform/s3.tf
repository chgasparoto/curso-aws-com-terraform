module "website_bucket" {
  source  = "chgasparoto/s3-object/aws"
  version = "1.0.0"

  name     = local.domain_name
  filepath = "${path.module}/../website/dist"

  policy = {
    json = jsonencode({
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
              "AWS:SourceArn" : "arn:aws:cloudfront::${local.account_id}:distribution/${local.distribution_id}"
            }
          }
        }
      ]
    })
  }
}
