resource "aws_dynamodb_table" "users" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}
