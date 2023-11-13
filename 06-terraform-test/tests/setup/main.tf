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

output "bucket_prefix" {
  value = random_pet.bucket_prefix.id
}
