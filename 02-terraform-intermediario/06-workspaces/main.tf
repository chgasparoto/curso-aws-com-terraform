terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }

  backend "s3" {
    bucket         = "tfstate-968339500772"
    key            = "05-workspaces/terraform.tfstate"
    region         = "eu-central-1"
    profile        = "tf014"
    dynamodb_table = "tflock-tfstate-968339500772"
  }
}

provider "aws" {
  region  = lookup(var.aws_region, local.env)
  profile = "tf014"
}

locals {
  env = terraform.workspace == "default" ? "dev" : terraform.workspace
}

resource "aws_instance" "web" {
  count = lookup(var.instance, local.env)["number"]

  ami           = lookup(var.instance, local.env)["ami"]
  instance_type = lookup(var.instance, local.env)["type"]

  tags = {
    Name = "Minha máquina web ${local.env}"
    Env  = local.env
  }
}
