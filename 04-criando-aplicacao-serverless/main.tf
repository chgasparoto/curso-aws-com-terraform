provider "aws" {
  region  = var.region
  profile = "tf_mac"
}

resource "random_id" "bucket" {
  byte_length = 8
}

