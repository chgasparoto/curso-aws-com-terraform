variable "aws_region"           {}
variable "ami"           {}
variable "instance_type" {}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
}

output "ip" {
  value = aws_instance.this.private_ip
}
