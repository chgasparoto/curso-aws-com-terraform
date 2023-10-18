# https://developer.hashicorp.com/terraform/language/meta-arguments/count

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
  count = var.create_random_strings ? 4 : 0

  length = 4
  prefix = count.index
}

output "pets" {
  value = var.create_random_strings ? [
    random_pet.this[0].id,
    random_pet.this[1].id,
    random_pet.this[2].id,
    random_pet.this[3].id
  ] : null
}
