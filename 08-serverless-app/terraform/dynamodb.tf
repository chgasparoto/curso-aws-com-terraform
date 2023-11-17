resource "aws_dynamodb_table" "this" {
  name         = local.namespaced_service_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = local.dynamodb_config.partition_key
  range_key    = local.dynamodb_config.sort_key

  attribute {
    name = local.dynamodb_config.partition_key
    type = "S"
  }

  attribute {
    name = local.dynamodb_config.sort_key
    type = "S"
  }

  attribute {
    name = local.dynamodb_config.gsi_sort_key
    type = "S"
  }

  global_secondary_index {
    name            = local.dynamodb_config.gsi_name
    hash_key        = local.dynamodb_config.sort_key
    range_key       = local.dynamodb_config.gsi_sort_key
    projection_type = "ALL"
  }
}
