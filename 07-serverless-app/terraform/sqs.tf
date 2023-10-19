resource "aws_sqs_queue" "this" {
  name                       = local.namespaced_service_name
  visibility_timeout_seconds = 30   # >= sqs lambda timout
  message_retention_seconds  = 3600 # after 1 hour, the message is sent to dlq
  sqs_managed_sse_enabled    = true

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
  policy    = data.aws_iam_policy_document.sqs_policy.json
  # policy = jsonencode({
  #   "Version" : "2012-10-17",
  #   "Id" : "sns_sqs_policy",
  #   "Statement" : [
  #     {
  #       "Sid" : "Allow SNS publish to SQS",
  #       "Effect" : "Allow",
  #       "Principal" : {
  #         "Service" : "sns.amazonaws.com"
  #       },
  #       "Action" : "sqs:SendMessage",
  #       "Resource" : "${aws_sqs_queue.this.arn}",
  #       "Condition" : {
  #         "ArnEquals" : {
  #           "aws:SourceArn" : "${aws_sns_topic.this.arn}"
  #         }
  #       }
  #     }
  #   ]
  # })
}


data "aws_iam_policy_document" "sqs_policy" {
  statement {
    sid    = "AllowSNSPublishToSQS"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    resources = [
      aws_sqs_queue.this.arn
    ]

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.this.arn]
    }
  }
}
