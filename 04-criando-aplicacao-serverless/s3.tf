resource "aws_s3_bucket" "todo" {
  bucket = "terraform-todo-${random_id.bucket.hex}"
}

resource "aws_s3_bucket_notification" "lambda" {
  bucket = aws_s3_bucket.todo.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

