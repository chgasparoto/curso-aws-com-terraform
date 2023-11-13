resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Ubuntu"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}
