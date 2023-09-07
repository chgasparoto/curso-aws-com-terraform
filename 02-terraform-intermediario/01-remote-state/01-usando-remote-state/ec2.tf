resource "aws_instance" "web" {
  ami           = var.instance_ami
  instance_type = var.instance_type
}
