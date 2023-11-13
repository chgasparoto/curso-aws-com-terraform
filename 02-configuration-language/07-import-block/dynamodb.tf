resource "aws_dynamodb_table" "tabela_do_cleber" {
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  hash_key                    = "id"
  name                        = "minha-tabela-no-dynamodb"
  range_key                   = null
  read_capacity               = 1
  restore_date_time           = null
  restore_source_name         = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = {}
  tags_all = {
    Project = "Curso AWS com Terraform"
  }
  write_capacity = 1
  attribute {
    name = "id"
    type = "S"
  }
  point_in_time_recovery {
    enabled = false
  }
  ttl {
    attribute_name = ""
    enabled        = false
  }
}
