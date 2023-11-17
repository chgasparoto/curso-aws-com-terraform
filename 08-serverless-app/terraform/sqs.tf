resource "aws_sqs_queue" "this" {
  name                       = local.namespaced_service_name
  visibility_timeout_seconds = 30   # >= timeout of sqs lambda
  message_retention_seconds  = 3600 # after 1 hour the message is sent to dlq

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.this_dlq.arn
    maxReceiveCount     = 4 # number of retries before sending to dlq
  })
}

resource "aws_sqs_queue" "this_dlq" {
  name = "${local.namespaced_service_name}-dlq"
}

resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.id
  policy    = data.aws_iam_policy_document.sqs_sns_policy.json
}

data "aws_iam_policy_document" "sqs_sns_policy" {
  statement {
    sid    = "AllowSNSPublishToSQS"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]

    resources = [
      aws_sqs_queue.this.arn
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values = [
        aws_sns_topic.this.arn
      ]
    }
  }
}
