resource "aws_iam_user" "example" {
  name = "example-user"
}

resource "aws_iam_user_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  user       = aws_iam_user.example.name

  depends_on = [aws_s3_bucket.bucket]
}
