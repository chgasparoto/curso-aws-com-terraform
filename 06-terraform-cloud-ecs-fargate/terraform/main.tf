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
  region  = var.aws_region
  version = "2.21.1"
}
