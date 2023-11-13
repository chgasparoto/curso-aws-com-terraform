resource "aws_s3_bucket" "bucket" {
  bucket = "${data.aws_caller_identity.this.account_id}-${random_pet.this.id}"
}
