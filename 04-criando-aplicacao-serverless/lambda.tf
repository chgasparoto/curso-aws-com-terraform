locals {
  layer_name  = "terraform_layer.zip"
  layers_path = "${path.module}/lambda-layers/nodejs"
}

resource "null_resource" "build_lambda_layers" {
  triggers = {
    layer_build = filemd5("${local.layers_path}/package.json")
  }

  provisioner "local-exec" {
    working_dir = local.layers_path
    command     = "npm install --production && cd ../ && zip -9 -r --quiet ${local.layer_name} *"
  }
}

resource "aws_lambda_layer_version" "this" {
  filename    = "${local.layers_path}/../${local.layer_name}"
  layer_name  = "terraform-layer"
  description = "joi: ^14.3.1"

  compatible_runtimes = ["nodejs8.10"]

  depends_on = [null_resource.build_lambda_layers]
}

data "archive_file" "s3" {
  type        = "zip"
  source_file = "${path.module}/lambdas/s3/index.js"
  output_path = "${path.module}/lambdas/s3/index.js.zip"
}

resource "aws_lambda_function" "s3" {
  function_name = "s3"
  handler       = "index.handler"
  role          = aws_iam_role.s3.arn
  runtime       = "nodejs12.x"
  layers        = [aws_lambda_layer_version.this.arn]

  filename         = data.archive_file.s3.output_path
  source_code_hash = data.archive_file.s3.output_base64sha256

  timeout     = 30
  memory_size = 128

  environment {
    variables = {
      TOPIC_ARN = aws_sns_topic.this.arn
    }
  }
}

resource "aws_lambda_permission" "s3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.todo.arn
}

data "archive_file" "dynamo" {
  type        = "zip"
  source_file = "${path.module}/lambdas/dynamo/index.js"
  output_path = "${path.module}/lambdas/dynamo/index.js.zip"
}

resource "aws_lambda_function" "dynamo" {
  function_name = "dynamo"
  handler       = "index.handler"
  role          = aws_iam_role.dynamo.arn
  runtime       = "nodejs12.x"
  layers        = [aws_lambda_layer_version.this.arn]

  filename         = data.archive_file.dynamo.output_path
  source_code_hash = data.archive_file.dynamo.output_base64sha256

  timeout     = 30
  memory_size = 128

  environment {
    variables = {
      TABLE = aws_dynamodb_table.this.name
    }
  }
}

resource "aws_lambda_permission" "dynamo" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamo.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:*/*"
}

resource "aws_lambda_permission" "sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dynamo.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}

