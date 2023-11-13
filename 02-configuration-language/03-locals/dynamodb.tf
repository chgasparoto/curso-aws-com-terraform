resource "aws_dynamodb_table" "games" {
  name                        = local.namespaced_service_name
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
}
