resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "Ubuntu - ${var.environment}"
    # Random = random_pet.this.id
  }
}
