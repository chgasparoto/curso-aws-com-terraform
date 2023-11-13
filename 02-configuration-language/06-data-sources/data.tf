data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "caixa_do_cleber" {
  bucket = "a-caixa-magica-do-cleber-001"
}

data "aws_dynamodb_table" "tableName" {
  name = "minha-tabela-no-dynamodb"
}
