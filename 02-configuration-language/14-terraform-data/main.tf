# https://developer.hashicorp.com/terraform/language/resources/terraform-data
# https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"

  default_tags {
    tags = {
      Lesson    = "Terraform Data Resource"
      ManagedBy = "Terraform"
    }

  }
}

variable "revision" {
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

# This resource has no convenient attribute which forces replacement,
# but can now be replaced by any change to the revision variable value.
resource "example_database" "test" {
  lifecycle {
    replace_triggered_by = [terraform_data.replacement]
  }
}

resource "aws_instance" "web" {
  # ...
}

resource "aws_instance" "database" {
  # ...
}

# A use-case for terraform_data is as a do-nothing container
# for arbitrary actions taken by a provisioner.
resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.web.id,
    aws_instance.database.id
  ]

  provisioner "local-exec" {
    command = "bootstrap-hosts.sh"
  }
}

resource "terraform_data" "example2" {
  provisioner "local-exec" {
    command     = "Get-Date > completed.txt"
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo $FOO $BAR $BAZ >> env_vars.txt"

    environment = {
      FOO = "bar"
      BAR = 1
      BAZ = "true"
    }
  }
}
