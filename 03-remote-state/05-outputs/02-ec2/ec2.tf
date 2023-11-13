resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = data.terraform_remote_state.vpc.outputs.subnet.id

  tags = {
    Name = "Ubuntu 2"
  }
}
