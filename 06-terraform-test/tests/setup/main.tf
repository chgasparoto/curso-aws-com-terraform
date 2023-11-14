terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_pet" "bucket_prefix" {
  length = 6
}

resource "random_integer" "read_capacity" {
  min = 1
  max = 10
}

resource "random_integer" "write_capacity" {
  min = 1
  max = 10
}

output "bucket_prefix" {
  value = random_pet.bucket_prefix.id
}

output "table_name" {
  value = random_pet.bucket_prefix.id
}

output "read_capacity" {
  value = random_integer.read_capacity.result
}

output "write_capacity" {
  value = random_integer.write_capacity.result
}
