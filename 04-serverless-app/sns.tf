resource "aws_sns_topic" "this" {
  name = var.service_name
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.dynamo.arn
}
