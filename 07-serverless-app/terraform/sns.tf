resource "aws_sns_topic" "this" {
  name = local.namespaced_service_name
}

resource "aws_sns_topic_subscription" "sqs" {
  protocol  = "sqs"
  topic_arn = aws_sns_topic.this.arn
  endpoint  = aws_sqs_queue.this.arn
}
