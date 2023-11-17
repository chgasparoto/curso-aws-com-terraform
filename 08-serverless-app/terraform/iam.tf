data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

module "iam_role_dynamodb_lambda" {
  source = "./modules/iam"

  iam_role_name   = "${local.namespaced_service_name}-dynamodb-lambda-role"
  iam_policy_name = "${local.namespaced_service_name}-dynamodb-lambda-execute-policy"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  create_log_perms_for_lambda = true

  permissions = [
    {
      sid = "AllowDynamoDBActions"
      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:UpdateItem",
      ]
      resources = [
        "arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.this.name}",
        "arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.this.name}/index/*",
      ]
    }
  ]
}

module "iam_role_s3_lambda" {
  source = "./modules/iam"

  iam_role_name   = "${local.namespaced_service_name}-s3-lambda-role"
  iam_policy_name = "${local.namespaced_service_name}-s3-lambda-execute-policy"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  create_log_perms_for_lambda = true

  permissions = [
    {
      sid = "AllowS3AndSNSActions"
      actions = [
        "s3:GetObject",
        "sns:Publish",
      ]
      resources = [
        "arn:aws:s3:::${aws_s3_bucket.todo.id}/*",
        "arn:aws:sns:${var.aws_region}:${local.account_id}:${aws_sns_topic.this.name}",
      ]
    }
  ]
}

module "iam_role_sqs_lambda" {
  source = "./modules/iam"

  iam_role_name   = "${local.namespaced_service_name}-s3-sqs-role"
  iam_policy_name = "${local.namespaced_service_name}-s3-sqs-execute-policy"

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  create_log_perms_for_lambda = true

  permissions = [
    {
      sid = "AllowSQSAndDynamoDBActions"
      actions = [
        "sqs:DeleteMessage",
        "sqs:ChangeMessageVisibility",
        "sqs:ReceiveMessage",
        "sqs:GetQueueAttributes",
        "dynamodb:PutItem",
      ]
      resources = [
        "arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.this.name}",
        "arn:aws:sqs:${var.aws_region}:${local.account_id}:${aws_sqs_queue.this.name}",
      ]
    }
  ]
}

resource "aws_iam_role" "apigw_send_logs_cw" {
  count = var.create_logs_for_apigw ? 1 : 0

  name        = "AllowApiGwSendLogsToCloudWatch"
  description = "Allows API Gateway to push logs to CloudWatch Logs."

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  ]

  assume_role_policy = jsonencode({
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Effect" : "Allow",
        "Principal" : { "Service" : "apigateway.amazonaws.com" },
        "Sid" : ""
      }
    ],
    "Version" : "2012-10-17"
  })
}
