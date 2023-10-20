provider "aws" {
  region  = var.aws_region
  profile = "tf_mac_air_m1_ggasparoto"

  default_tags {
    tags = local.common_tags
  }
}
