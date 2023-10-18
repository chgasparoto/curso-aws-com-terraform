# https://developer.hashicorp.com/terraform/language/expressions/strings

terraform {
  required_version = "~> 1.6"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

resource "random_pet" "this" {
  length = 4
}

variable "environment" {
  type    = string
  default = "dev"
}

locals {
  # Interpolation
  literal_string      = "Isto é uma string literal, sendo uma sequência de caracteres dentro de aspas duplas"
  concatenated_string = "${random_pet.this.id}-text-123-${var.environment}"
  function_string     = replace(local.literal_string, "uma", "uMa")

  # Heredoc
  heredoc_string = <<EOT
  hello
  world
  EOT

  indented_heredoc_string = <<-EOT
  hello
    world
  EOT

  # JSON or YML
  # https://developer.hashicorp.com/terraform/language/expressions/strings#generating-json-or-yaml
  json = jsonencode({
    a = 1
    b = "hello"
  })
}

output "locals" {
  value = [
    local.literal_string,
    local.concatenated_string,
    local.function_string,
    local.heredoc_string,
    local.indented_heredoc_string,
    local.json,
  ]
}
