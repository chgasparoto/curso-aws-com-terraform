resource "aws_sns_topic" "this" {
  name         = var.sns_topic_name
  display_name = "S3 Data"
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.dynamo.arn
}

