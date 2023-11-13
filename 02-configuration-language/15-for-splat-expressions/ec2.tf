resource "aws_instance" "example" {
  for_each = {
    web = {
      name = "Web server"
      type = "t3.medium"
    }
    ci_cd = {
      name = "CI/CD server"
      type = "t3.micro"
    }
  }

  ami           = data.aws_ami.ubuntu.id
  instance_type = lookup(each.value, "type", null)

  tags = {
    Name = "${each.key}: ${lookup(each.value, "name", null)}"
  }
}
