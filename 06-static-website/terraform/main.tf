provider "aws" {
  region  = var.aws_region
  profile = "tf_mac_air_m1_ggasparoto"

  default_tags {
    tags = local.common_tags
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "tf_mac_air_m1_ggasparoto"

  alias = "us_east_1"

  default_tags {
    tags = local.common_tags
  }
}

resource "random_pet" "website" {
  length = 5
}
