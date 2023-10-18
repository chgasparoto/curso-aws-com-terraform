data "aws_caller_identity" "this" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = var.ec2_ami_id != null ? var.ec2_ami_id : data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  tags = {
    "Name" = "Ubuntu"
  }
}
