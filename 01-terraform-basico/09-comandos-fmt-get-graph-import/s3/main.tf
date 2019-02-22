resource "aws_s3_bucket" "this" {
  bucket = "${var.name}"
  acl    = "${var.acl}"

  versioning {
    enabled = "${var.versioning}"
  }

  tags = "${var.tags}"
}

resource "aws_s3_bucket_object" "this" {
  count = "${var.create_object ? 1 : 0}"

  bucket = "${aws_s3_bucket.this.id}"
  key    = "${var.object_key}"
  source = "${var.object_source}"
  etag   = "${md5(file(var.object_source))}"
}
