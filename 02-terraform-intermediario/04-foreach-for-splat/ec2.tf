resource "aws_instance" "this" {
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

  ami           = "ami-0ce70c4057dc39200"
  instance_type = lookup(each.value, "type", null)

  tags = {
    Project = "Curso AWS com Terraform"
    Name    = "${each.key}: ${lookup(each.value, "name", null)}"
    Lesson  = "Foreach, For, Splat"
  }
}
