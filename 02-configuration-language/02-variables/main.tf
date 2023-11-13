# https://developer.hashicorp.com/terraform/language/values/variables

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_dynamodb_table" "games" {
  name                        = var.database_config.table_name
  billing_mode                = "PROVISIONED"
  read_capacity               = var.database_config.read_capacity
  write_capacity              = var.database_config.write_capacity
  deletion_protection_enabled = var.database_config.deletion_protection

  hash_key  = var.database_config.hash_key.name
  range_key = var.database_config.range_key.name

  attribute {
    name = var.database_config.hash_key.name
    type = var.database_config.hash_key.type
  }

  attribute {
    name = var.database_config.range_key.name
    type = var.database_config.range_key.type
  }

  tags = merge(var.tags, {
    "Fields" = join("_", var.dynamodb_field_list)
  })
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}
