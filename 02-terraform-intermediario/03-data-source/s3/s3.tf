resource "aws_s3_bucket" "this" {
  bucket = "my-bucket-${random_id.this.hex}"
}

resource "aws_s3_bucket_object" "this" {
  bucket = aws_s3_bucket.this.bucket
  key    = "instances/instances-${local.instance.ami}.txt"
  source = "output.json"
  etag   = filemd5("output.json")
}
