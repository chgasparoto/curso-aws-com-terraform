terraform {
  required_version = "~> 0.12.5"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "curso-aws-com-terraform"

    workspaces {
      name = "default"
    }
  }
}

provider "aws" {
  region  = var.region
  version = "2.22.0"
}