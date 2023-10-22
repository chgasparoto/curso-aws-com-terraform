# --------------- LAMBDA CODE --------------------
resource "null_resource" "build" {
  triggers = {
    code_hash = local.code_hash
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../"
    command     = "npm run build"
  }
}

resource "random_uuid" "this" {
  keepers = {
    code_hash = local.code_hash
  }
}

data "archive_file" "codebase" {
  depends_on = [
    null_resource.build
  ]

  type        = "zip"
  source_dir  = "${path.module}/../dist"
  output_path = "files/${random_uuid.this.result}.zip"
}

# --------------- LAMBDA INFRA --------------------

module "lambda_s3" {
  source = "./modules/lambda"

  name            = "${local.namespaced_service_name}-s3"
  description     = "Reads file from S3 and publishes messages into a SNS topic"
  iam_role_arn    = module.iam_role_s3_lambda.iam_role_arn
  handler         = "${local.lambdas_path}/s3.handler"
  timeout_in_secs = 15
  code_hash       = data.archive_file.codebase.output_base64sha256

  s3_config = {
    bucket = aws_s3_bucket.lambda_artefacts.bucket
    key    = aws_s3_object.lambda_artefacts.key
  }

  env_vars = {
    TOPIC_ARN = aws_sns_topic.this.arn
    DEBUG     = var.environment == "dev"
  }
}

module "lambda_dynamodb" {
  source = "./modules/lambda"

  name            = "${local.namespaced_service_name}-dynamodb"
  description     = "Triggered by API Gateway to save data into DynamoDB table"
  handler         = "${local.lambdas_path}/dynamodb.handler"
  iam_role_arn    = module.iam_role_dynamodb_lambda.iam_role_arn
  timeout_in_secs = 15
  memory_in_mb    = 256
  code_hash       = data.archive_file.codebase.output_base64sha256

  s3_config = {
    bucket = aws_s3_bucket.lambda_artefacts.bucket
    key    = aws_s3_object.lambda_artefacts.key
  }

  env_vars = {
    JWT_SECRET = aws_cognito_user_pool_client.this.id
    TABLE_NAME = aws_dynamodb_table.this.name
    GSI_NAME   = local.dynamodb_config.gsi_name
    DEBUG      = var.environment == "dev"

    AWS_NODEJS_CONNECTION_REUSE_ENABLED = 1
  }
}

module "lambda_sqs" {
  source = "./modules/lambda"

  name            = "${local.namespaced_service_name}-sqs"
  description     = "Triggered by SQS to forward data to API Gateway"
  handler         = "${local.lambdas_path}/sqs.handler"
  iam_role_arn    = module.iam_role_sqs_lambda.iam_role_arn
  timeout_in_secs = 15
  memory_in_mb    = 256
  code_hash       = data.archive_file.codebase.output_base64sha256

  s3_config = {
    bucket = aws_s3_bucket.lambda_artefacts.bucket
    key    = aws_s3_object.lambda_artefacts.key
  }

  env_vars = {
    JWT_SECRET = aws_cognito_user_pool_client.this.id
    TABLE_NAME = aws_dynamodb_table.this.name
    GSI_NAME   = local.dynamodb_config.gsi_name
    DEBUG      = var.environment == "dev"

    AWS_NODEJS_CONNECTION_REUSE_ENABLED = 1
  }
}

# --------------- LAMBDA TRIGGERS --------------------

resource "aws_lambda_permission" "s3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_s3.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.todo.arn
}

resource "aws_lambda_permission" "dynamo" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_dynamodb.name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*"
}

resource "aws_lambda_event_source_mapping" "lambda_sqs" {
  event_source_arn = aws_sqs_queue.this.arn
  function_name    = module.lambda_sqs.name
}
