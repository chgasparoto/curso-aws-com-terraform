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

resource "random_pet" "string" {
  length = 4
}

variable "environment" {
  type    = string
  default = "dev"
}

locals {
  # Interpolation
  literal_string    = "Isto é uma string literal, sendo uma sequência de caracteres dentro de aspas duplas"
  concatened_string = "${random_pet.string.id}-texto-aleatório-${var.environment}"
  function_string   = replace(local.literal_string, "uma", "UMA")

  # Heredoc
  heredoc_string = <<EOT
  hello
  world
  EOT

  indented_heredoc_string = <<-EOT
  hello
    world
      Terraform
  EOT

  # JSON or YML
  # https://developer.hashicorp.com/terraform/language/expressions/strings#generating-json-or-yaml
  json = jsonencode({
    hello = "world"
    foo   = "bar"
    a     = "b"
  })
  decoded_json = jsondecode(local.json)
}

output "locals" {
  value = {
    literal_string    = local.literal_string
    concatened_string = local.concatened_string
    function_string   = local.function_string

    heredoc_string          = local.heredoc_string
    indented_heredoc_string = local.indented_heredoc_string

    json         = local.json
    decoded_json = local.decoded_json["foo"]
  }
}
