# https://developer.hashicorp.com/terraform/language/values/locals

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = local.common_tags
  }
}
