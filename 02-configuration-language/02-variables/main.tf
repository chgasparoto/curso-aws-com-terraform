# https://developer.hashicorp.com/terraform/language/values/variables

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_dynamodb_table" "example" {
  name           = var.db_config.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.db_config.read_capacity
  write_capacity = var.db_config.write_capacity
  hash_key       = var.allowed_fields[0]
  range_key      = var.allowed_fields[1]

  deletion_protection_enabled = var.db_config.deletion_protection

  attribute {
    name = var.allowed_fields[0]
    type = "S"
  }

  attribute {
    name = var.allowed_fields[1]
    type = "S"
  }

  tags = var.tags
}
