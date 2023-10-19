# https://developer.hashicorp.com/terraform/language/data-sources

# Data sources allow Terraform to use information defined
# outside of Terraform, defined by another separate
# Terraform configuration, or modified by functions.
provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"
}
