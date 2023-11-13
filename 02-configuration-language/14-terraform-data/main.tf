# https://developer.hashicorp.com/terraform/language/resources/terraform-data
# https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_macm1_ggasparoto"

  default_tags {
    tags = {
      "Project"    = "Curso AWS com Terraform"
      "Module"     = "Configuration Language"
      "Component"  = "terraform_data, local-exec"
      "CreatedAt"  = "2023-11-12"
      "ManagedBy"  = "Terraform"
      "Owner"      = "Cleber Gasparoto"
      "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
    }
  }
}

resource "random_pet" "this" {
  length = 5
}

resource "terraform_data" "this" {
  input            = "algum valor: variable, local, reference, etc"
  triggers_replace = "outro valor: string, map, etc"
}

variable "revision" {
  type    = number
  default = 1
}

resource "terraform_data" "replacement" {
  input = var.revision
}

resource "terraform_data" "provisioners" {
  triggers_replace = aws_instance.example.private_ip

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}
