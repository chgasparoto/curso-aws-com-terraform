# https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

terraform {
  required_version = "~> 1.6"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

variable "create_random_strings" {
  type    = bool
  default = true
}

resource "random_pet" "this" {
  for_each = var.create_random_strings ? {
    dog  = 4
    cat  = 2
    bird = 3
    pig  = 5
  } : {}

  length = each.value
  prefix = each.key
}

output "pets" {
  value = var.create_random_strings ? [
    random_pet.this["dog"].id,
    random_pet.this["cat"].id,
    random_pet.this["bird"].id,
    random_pet.this["pig"].id
  ] : null
}
