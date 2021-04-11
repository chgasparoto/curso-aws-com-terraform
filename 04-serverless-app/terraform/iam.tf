data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# --------------- S3 Role --------------------

data "aws_iam_policy_document" "s3" {
  statement {
    sid       = "AllowS3AndSNSActions"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:*",
      "sns:*",
    ]
  }

  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:*:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "s3" {
  name               = "${var.service_domain}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

resource "aws_iam_policy" "s3" {
  name   = "${aws_lambda_function.s3.function_name}-lambda-execute-policy"
  policy = data.aws_iam_policy_document.s3.json
}

resource "aws_iam_role_policy_attachment" "s3-execute" {
  policy_arn = aws_iam_policy.s3.arn
  role       = aws_iam_role.s3.name
}

# --------------- Dynamo Role --------------------

data "aws_iam_policy_document" "dynamo" {
  statement {
    sid       = "AllowDynamoPermissions"
    effect    = "Allow"
    resources = ["*"]

    actions = ["dynamodb:*"]
  }

  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:*:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "dynamo" {
  name               = "dynamo-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

resource "aws_iam_policy" "dynamo" {
  name   = "dynamo-lambda-execute-policy"
  policy = data.aws_iam_policy_document.dynamo.json
}

resource "aws_iam_role_policy_attachment" "dynamo" {
  policy_arn = aws_iam_policy.dynamo.arn
  role       = aws_iam_role.dynamo.name
}
