resource "random_pet" "bucket" {}

resource "aws_s3_bucket" "todo" {
  bucket = "${var.service_domain}-${random_pet.bucket.id}"
  tags   = local.common_tags
}

resource "aws_s3_bucket_notification" "lambda" {
  bucket = aws_s3_bucket.todo.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3.arn
    events              = ["s3:ObjectCreated:*"]
  }
}
