resource "random_pet" "bucket" {}

resource "aws_s3_bucket" "todo" {
  bucket = "${var.service_domain}-${random_pet.bucket.id}"
}

resource "aws_s3_bucket_notification" "lambda" {
  bucket = aws_s3_bucket.todo.id

  lambda_function {
    lambda_function_arn = module.lambda_s3.arn
    events              = ["s3:ObjectCreated:*"]
  }
}

resource "aws_s3_bucket" "lambda_artefacts" {
  bucket = "${local.account_id}-lambda-artefacts"
}

resource "aws_s3_bucket_versioning" "lambda_artefacts" {
  bucket = aws_s3_bucket.lambda_artefacts.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "lambda_artefacts" {
  bucket       = aws_s3_bucket.lambda_artefacts.id
  key          = "builds/${random_uuid.this.result}.zip"
  source       = data.archive_file.codebase.output_path
  content_type = "application/zip"
}
