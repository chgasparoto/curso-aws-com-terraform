resource "aws_sns_topic" "this" {
  name = local.namespaced_service_name
}

resource "aws_sns_topic_subscription" "sqs" {
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.this.arn
  topic_arn = aws_sns_topic.this.arn
}
