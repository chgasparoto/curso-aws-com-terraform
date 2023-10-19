# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "this" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket
# data "aws_s3_bucket" "logs" {
#   bucket = "${local.account_id}-nome-do-bucket-dentro-do-console-da-aws"
# }
