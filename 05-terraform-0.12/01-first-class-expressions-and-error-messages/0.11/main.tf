variable "ami" {}
variable "instance_type" {}

variable "vpc_security_group_ids" {
  type = "list"
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "this" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  vpc_security_group_ids = "${var.security_group_id != "" ? list(var.security_group_id) : list()}"
}

output "ip" {
  value = "${aws_instance.this.private_ip}"
}
