resource "aws_dynamodb_table" "users" {
  name         = var.table_name != null ? var.table_name : random_pet.service_name.id
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
}
