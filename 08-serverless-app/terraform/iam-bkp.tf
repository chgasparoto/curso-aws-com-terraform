# data "aws_iam_policy_document" "lambda_assume_role" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["lambda.amazonaws.com"]
#     }
#   }
# }

# --------------- S3 Role --------------------

# module "iam_role_s3_lambda" {
#   source = "./modules/iam"

#   iam_role_name   = "${local.namespaced_service_name}-s3-lambda-role"
#   iam_policy_name = "${local.namespaced_service_name}-s3-lambda-execute-policy"

#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

#   create_log_perms_for_lambda = true

#   permissions = [
#     {
#       sid = "AllowS3AndSNSActions"
#       actions = [
#         "s3:GetObject",
#         "sns:Publish",
#       ]
#       resources = [
#         "arn:aws:s3:::${aws_s3_bucket.todo.id}/*",
#         "arn:aws:sns:${var.aws_region}:${local.account_id}:${aws_sns_topic.this.name}"
#       ]
#     }
#   ]
# }

# data "aws_iam_policy_document" "s3" {
#   statement {
#     sid    = "AllowS3AndSNSActions"
#     effect = "Allow"
#     resources = [
#       "arn:aws:s3:::${aws_s3_bucket.todo.id}/*",
#       "arn:aws:sns:${var.aws_region}:${local.account_id}:${aws_sns_topic.this.name}"
#     ]

#     actions = [
#       "s3:GetObject",
#       "sns:Publish",
#     ]
#   }

#   statement {
#     sid       = "AllowCreatingLogGroups"
#     effect    = "Allow"
#     resources = ["arn:aws:logs:*:*:*"]
#     actions   = ["logs:CreateLogGroup"]
#   }

#   statement {
#     sid       = "AllowWritingLogs"
#     effect    = "Allow"
#     resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

#     actions = [
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#     ]
#   }
# }

# resource "aws_iam_role" "s3" {
#   name               = "${var.service_domain}-lambda-role"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
# }

# resource "aws_iam_policy" "s3" {
#   name   = "${module.lambda_s3.name}-lambda-execute-policy"
#   policy = data.aws_iam_policy_document.s3.json
# }

# resource "aws_iam_role_policy_attachment" "s3_execute" {
#   policy_arn = aws_iam_policy.s3.arn
#   role       = aws_iam_role.s3.name
# }

# --------------- Dynamo Role --------------------

# data "aws_iam_policy_document" "dynamo" {
#   statement {
#     sid    = "AllowDynamoPermissions"
#     effect = "Allow"
#     resources = [
#       "arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.this.name}",
#       "arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.this.name}/index/*",
#     ]

#     actions = [
#       "dynamodb:BatchGetItem",
#       "dynamodb:BatchWriteItem",
#       "dynamodb:PutItem",
#       "dynamodb:DeleteItem",
#       "dynamodb:GetItem",
#       "dynamodb:Query",
#       "dynamodb:UpdateItem",
#     ]
#   }

#   statement {
#     sid       = "AllowCreatingLogGroups"
#     effect    = "Allow"
#     resources = ["arn:aws:logs:*:*:*"]
#     actions   = ["logs:CreateLogGroup"]
#   }

#   statement {
#     sid       = "AllowWritingLogs"
#     effect    = "Allow"
#     resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

#     actions = [
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#     ]
#   }
# }

# resource "aws_iam_role" "dynamo" {
#   name               = "dynamo-lambda-role"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
# }

# resource "aws_iam_policy" "dynamo" {
#   name   = "dynamo-lambda-execute-policy"
#   policy = data.aws_iam_policy_document.dynamo.json
# }

# resource "aws_iam_role_policy_attachment" "dynamo" {
#   policy_arn = aws_iam_policy.dynamo.arn
#   role       = aws_iam_role.dynamo.name
# }

# --------------- SQS Role --------------------

# data "aws_iam_policy_document" "sqs" {
#   statement {
#     sid    = "AllowSQSPermissions"
#     effect = "Allow"
#     resources = [
#       "arn:aws:dynamodb:${var.aws_region}:${local.account_id}:table/${aws_dynamodb_table.this.name}",
#       "arn:aws:sqs:${var.aws_region}:${local.account_id}:${aws_sqs_queue.this.name}"
#     ]

#     actions = [
#       "sqs:DeleteMessage",
#       "sqs:ChangeMessageVisibility",
#       "sqs:ReceiveMessage",
#       "sqs:GetQueueAttributes",
#       "dynamodb:PutItem",
#     ]
#   }

#   statement {
#     sid       = "AllowCreatingLogGroups"
#     effect    = "Allow"
#     resources = ["arn:aws:logs:*:*:*"]
#     actions   = ["logs:CreateLogGroup"]
#   }

#   statement {
#     sid       = "AllowWritingLogs"
#     effect    = "Allow"
#     resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

#     actions = [
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#     ]
#   }
# }

# resource "aws_iam_role" "sqs" {
#   name               = "sqs-lambda-role"
#   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
# }

# resource "aws_iam_policy" "sqs" {
#   name   = "sqs-lambda-execute-policy"
#   policy = data.aws_iam_policy_document.sqs.json
# }

# resource "aws_iam_role_policy_attachment" "sqs" {
#   policy_arn = aws_iam_policy.sqs.arn
#   role       = aws_iam_role.sqs.name
# }
