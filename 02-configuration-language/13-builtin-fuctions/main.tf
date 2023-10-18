# https://developer.hashicorp.com/terraform/language/functions

terraform {
  required_version = "~> 1.6"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"

  default_tags {
    tags = {
      Lesson    = "Built-in Functions"
      ManagedBy = "Terraform"
    }

  }
}

resource "random_pet" "this" {
  length = 5
}

locals {
  bucket_name = "caso-o-bucket-tenha-um-nome-muito-grande-sera-preciso-limitar-para-nao-causar-um-ao-aplicar-o-terraform"
  foo         = { bar = "baz" }

  # String
  replace = lower(replace("Uma string com espaço", " ", "-"))
  substr  = substr(local.bucket_name, 0, 63)
  length  = length(local.bucket_name)
  regex   = regex("[a-z]+", "53453453.345345aaabbbccc23454")

  # Collection
  contains = contains(["a", "b", "c"], "a")
  element  = element(["a", "b", "c"], 1)
  index    = index(["a", "b", "c"], "b")
  keys     = keys({ a = 1, c = 2, d = 3 })
  lookup   = lookup({ a = "ay", b = "bee" }, "c", "what?")

  # Encoding
  jsonencode   = jsonencode({ "hello" = "world" })
  base64encode = base64encode("Hello World")
  template     = templatefile("food.tftpl", { food : "pasta" })

  # Type conversion
  can = can(formatdate("", timestamp()))
  try = try(local.foo.boop, "fallback")
}

output "locals" {
  value = {
    string = {
      replace = local.replace
      substr  = local.substr
      length  = local.length
      regex   = local.regex
    }
    collection = {
      contains = local.contains
      element  = local.element
      index    = local.index
      keys     = local.keys
      lookup   = local.lookup
    }
    encoding = {
      jsonencode   = local.jsonencode
      base64encode = local.base64encode
      template     = local.template
    }
    type = {
      can = local.can
      try = local.try
    }
  }
}
