provider "aws" {
  region = "${var.region}"
}

resource "random_id" "bucket" {
  byte_length = 8
}
