# variables 0-1
# provider 0-n
# run 1-n

variables {
  aws_region  = "eu-west-3" # Paris
  bucket_name = "este-e-um-nome-de-balde-aleatorio-1237890"
}

provider "aws" {
  region = var.aws_region
}

# unit test
run "validate_inputs" {
  # tfstate in-memory global - para todos os blocos run sem module

  command = plan

  variables {
    aws_region  = "europe-west-3"
    bucket_name = "Nome Inválido"
  }

  expect_failures = [
    var.aws_region,
    var.bucket_name
  ]
}

run "setup" {
  # tfstate in-memory - module setup

  module {
    source = "./tests/setup"
  }
}

# integration test
run "create_buckets" {
  # tfstate in-memory global

  variables {
    bucket_name = run.setup.bucket_prefix
  }

  assert {
    condition     = aws_s3_bucket.s3_bucket.bucket == var.bucket_name
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

run "website_is_running" {
  command = plan

  module {
    source = "./tests/final"
  }

  variables {
    endpoint = run.create_buckets.website_endpoint
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}
