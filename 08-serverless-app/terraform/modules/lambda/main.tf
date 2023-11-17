resource "aws_lambda_function" "this" {
  function_name = var.name
  description   = var.description

  role          = var.iam_role_arn
  runtime       = var.runtime
  architectures = var.architectures
  handler       = var.handler

  timeout     = var.timeout_in_secs
  memory_size = var.memory_in_mb

  s3_bucket        = var.s3_config.bucket
  s3_key           = var.s3_config.key
  source_code_hash = var.code_hash

  environment {
    variables = var.env_vars
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.log_retetion_days
}
