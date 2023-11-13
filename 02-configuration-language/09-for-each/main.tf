# https://developer.hashicorp.com/terraform/language/meta-arguments/for_each

variable "create_random_pets" {
  type    = bool
  default = true
}

resource "random_pet" "for_each" {
  for_each = var.create_random_pets ? {
    dog  = 4
    cat  = 2
    bird = 3
    pig  = 5
  } : {}

  length = each.value
  prefix = each.key
}

output "pets" {
  value = var.create_random_pets ? [
    random_pet.for_each["dog"].id,
    random_pet.for_each["cat"].id,
    random_pet.for_each["bird"].id,
    random_pet.for_each["pig"].id,
  ] : null
}
