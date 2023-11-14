terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_pet" "service_name" {
  length = 6
}

resource "random_integer" "read_capacity" {
  min = 1
  max = 8
}

resource "random_integer" "write_capacity" {
  min = 1
  max = 8
}

output "bucket_name" {
  value = random_pet.service_name.id
}

output "table_name" {
  value = random_pet.service_name.id
}

output "read_capacity" {
  value = random_integer.read_capacity.result
}

output "write_capacity" {
  value = random_integer.write_capacity.result
}
