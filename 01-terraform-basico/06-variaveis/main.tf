provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "web" {
  ami           = "${var.ami}"
  instance_type = "${var.type}"

  # ipv6_addresses = "${var.ips}"

  tags = "${var.tags}"
}
