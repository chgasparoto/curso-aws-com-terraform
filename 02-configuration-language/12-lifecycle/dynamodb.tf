resource "aws_dynamodb_table" "users" {
  name         = "users-${random_pet.this.id}"
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

  lifecycle {
    prevent_destroy = false
  }
}
