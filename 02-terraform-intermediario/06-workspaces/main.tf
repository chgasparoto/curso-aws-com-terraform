terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "tf014"
}

locals {
  env = terraform.workspace
}

resource "aws_instance" "web" {
  ami           = lookup(var.ami, local.env)
  instance_type = lookup(var.type, local.env)

  tags = {
    Name = "Minha máquina web ${local.env}"
    Env  = local.env
  }
}
