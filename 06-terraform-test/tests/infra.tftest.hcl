# run => 1-n
# provider => 0-n
# variables => 0-1

# Terraform roda os testes na sequência em que foram declarados

variables {
  aws_region     = "eu-west-3" # Paris
  bucket_name    = "este-e-um-nome-de-balde-aleatorio-1234567890"
  table_name     = "usuarios"
  read_capacity  = 5
  write_capacity = 5
}

provider "aws" {
  region = var.aws_region
}

# unit test
run "validate_inputs" {
  # tfstate in-memory global -> pois não tem o bloco `module` configurado

  command = plan

  variables {
    aws_region     = "europe-west-3"
    bucket_name    = "nome de bucket invalido"
    table_name     = "nome de tabela invalido"
    read_capacity  = 0
    write_capacity = -5
  }

  expect_failures = [
    var.aws_region,
    var.bucket_name,
    var.table_name,
    var.read_capacity,
    var.write_capacity
  ]
}

run "setup" {
  # tfstate in-memory -> module setup

  module {
    source = "./tests/setup"
  }
}

# integration test
run "create_tables" {
  # tfstate in-memory global -> pois não tem o bloco `module` configurado

  variables {
    table_name     = run.setup.table_name
    read_capacity  = run.setup.read_capacity
    write_capacity = run.setup.write_capacity
  }

  assert {
    condition     = aws_dynamodb_table.users.name == run.setup.table_name
    error_message = "Invalid table name"
  }

  assert {
    condition     = aws_dynamodb_table.users.read_capacity == run.setup.read_capacity
    error_message = "Invalid table read capacity"
  }

  assert {
    condition     = aws_dynamodb_table.users.write_capacity == run.setup.write_capacity
    error_message = "Invalid table write capacity"
  }
}

# integration test
run "create_buckets" {
  # tfstate in-memory global

  variables {
    bucket_name = run.setup.bucket_name
  }

  assert {
    condition     = aws_s3_bucket.s3_bucket.id == run.setup.bucket_name
    error_message = "Invalid bucket name"
  }

  assert {
    condition     = aws_s3_object.index.etag == filemd5("./www/index.html")
    error_message = "Invalid eTag for index.html"
  }

  assert {
    condition     = aws_s3_object.error.etag == filemd5("./www/error.html")
    error_message = "Invalid eTag for error.html"
  }
}

# unit test
run "website_is_running" {
  # tfstate in-memory -> module http

  command = plan

  module {
    source = "./tests/http"
  }

  variables {
    endpoint = run.create_buckets.website_endpoint
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}
