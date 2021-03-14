terraform {
  required_version = "0.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.32.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile
  alias   = "us-east-1"
}

resource "random_pet" "website" {
  length = 5
}

resource "null_resource" "website" {
  triggers = {
    # https://stackoverflow.com/a/66501021/2614584
    dir_sha1 = sha1(join("", [for f in fileset("${local.website_filepath}/src", "**") : filesha1("${local.website_filepath}/src/${f}")]))
  }

  provisioner "local-exec" {
    working_dir = local.website_filepath
    command     = "npm ci && npm run build"
  }
}
