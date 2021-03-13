terraform {
  required_version = "0.14.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
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
  profile = "tf014"
  alias   = "us-east-1"
}

resource "random_pet" "website" {
  length = 5
}

resource "null_resource" "build_website" {
  triggers = {
    dir_sha1 = sha1(join("", [
      for f in fileset(local.website_filepath, "**") : filesha1("${local.website_filepath}/${f}")
      ]
    ))
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../website"
    command     = "npm ci && npm run build"
  }
}
