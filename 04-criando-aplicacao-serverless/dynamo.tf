resource "aws_dynamodb_table" "this" {
  name           = var.dbname
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "TodoId"

  attribute {
    name = "TodoId"
    type = "S"
  }

  tags = {
    Name        = var.dbname
    Environment = var.env
  }
}

resource "aws_dynamodb_table_item" "this" {
  table_name = aws_dynamodb_table.this.name
  hash_key   = aws_dynamodb_table.this.hash_key

  item = <<ITEM
{
  "TodoId": {"S": "1"},
  "Task": {"S": "Aprender Terraform"},
  "Done": {"S": "0"}
}
ITEM

}

