terraform {
  required_version = "~> 0.12.5"

  backend "remote" {}
}

provider "aws" {
  region  = var.region
  version = "2.22.0"
}