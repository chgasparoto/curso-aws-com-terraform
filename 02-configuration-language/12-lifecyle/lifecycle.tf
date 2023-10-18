# prevent destroy
resource "aws_dynamodb_table" "users" {
  name         = "users"
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "null_resource" "replacement_trigger" {
  triggers = {
    "startup_script" = filesha256("user_data.sh")
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  user_data     = filebase64("user_data.sh")

  tags = {
    "Name" = "Ubuntu"
    "Env"  = "Dev"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
    replace_triggered_by = [
      null_resource.replacement_trigger
    ]

    # The AMI ID must refer to an AMI that contains an operating system
    # for the `x86_64` architecture.
    precondition {
      condition     = data.aws_ami.ubuntu.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture."
    }

    # The EC2 instance must be allocated a public DNS hostname.
    postcondition {
      condition     = self.public_dns != ""
      error_message = "EC2 instance must be in a VPC that has public DNS hostnames enabled."
    }
  }
}
