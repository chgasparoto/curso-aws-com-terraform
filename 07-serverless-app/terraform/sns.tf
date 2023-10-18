resource "aws_sns_topic" "this" {
  name = var.service_name
}

resource "aws_sns_topic_subscription" "lambda" {
  endpoint  = aws_lambda_function.dynamo.arn
  protocol  = "lambda"
  topic_arn = aws_sns_topic.this.arn
}
