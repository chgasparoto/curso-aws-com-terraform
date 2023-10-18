resource "aws_s3_object" "this" {
  for_each = var.filepath != "" ? fileset(var.filepath, "**") : []

  bucket       = var.bucket
  key          = var.key_prefix != "" ? "${var.key_prefix}/${each.value}" : each.value
  source       = "${var.filepath}/${each.value}"
  etag         = filemd5("${var.filepath}/${each.value}")
  content_type = lookup(var.file_types, regex("\\.[^\\.]+\\z", "${var.filepath}/${each.value}"), var.default_file_type)
}
