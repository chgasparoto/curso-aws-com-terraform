# https://developer.hashicorp.com/terraform/language/meta-arguments/count

variable "create_random_pets" {
  type    = bool
  default = true
}

resource "random_pet" "count" {
  count = var.create_random_pets ? 1 : 0

  length = 4
  prefix = count.index
}

output "pets" {
  value = var.create_random_pets ? [
    random_pet.count[0].id,
    # random_pet.count[1].id,
    # random_pet.count[2].id,
    # random_pet.count[3].id,
    # random_pet.count[4].id,
    # random_pet.count[5].id,
  ] : null
}
