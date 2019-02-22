provider "aws" {
  region = "${var.region}"
}

module "bucket" {
  source = "../../08-modulos/s3"

  name       = "${var.bucket_name}-${var.env}"
  versioning = true

  tags = {
    "Env"  = "${var.env}"
    "Name" = "Terraform Remote State"
  }
}
