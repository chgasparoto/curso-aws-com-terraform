terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
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
      "CreateAt"  = "2023-10-01"
      "ManagedBy" = "Terraform"
      "Module"    = "Modules"
    }
  }
}

resource "random_pet" "service_name" {
  length = 6
}

# TODO: trocar pelo modulo de ec2 ou dynamodb
# module "s3" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "~> 3.15.1"

#   bucket = random_pet.service_name.id
# }

# output "bucket_name" {
#   value = module.s3.s3_bucket_id
# }

module "s3_local" {
  source = "../02-creating-modules"
}

output "bucket_name_local" {
  value = module.s3_local.name
}
