provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "curso-aws-terraform-remote-state-dev"
    key    = "ec2/ec2.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
}
