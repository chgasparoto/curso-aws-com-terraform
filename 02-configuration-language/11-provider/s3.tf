resource "aws_s3_bucket" "bucket" {
  bucket = "${data.aws_caller_identity.this.account_id}-${random_pet.this.id}"
}

resource "aws_s3_bucket" "bucket_sao_paulo" {
  bucket = "${data.aws_caller_identity.this.account_id}-${random_pet.this.id}-sp"

  provider = aws.sao_paulo
}
