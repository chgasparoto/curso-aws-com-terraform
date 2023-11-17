data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.permissions

    content {
      sid       = statement.value["sid"]
      effect    = statement.value["effect"]
      resources = statement.value["resources"]
      actions   = statement.value["actions"]
    }
  }

  dynamic "statement" {
    for_each = var.create_log_perms_for_lambda ? [
      {
        sid       = "AllowCreatingLogGroups"
        resources = ["arn:aws:logs:*:*:*"]
        actions   = ["logs:CreateLogGroup"]
      },
      {
        sid       = "AllowWritingLogs"
        resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]
        actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      }
    ] : []

    content {
      sid       = statement.value["sid"]
      effect    = "Allow"
      resources = statement.value["resources"]
      actions   = statement.value["actions"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "this" {
  name   = var.iam_policy_name
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}
