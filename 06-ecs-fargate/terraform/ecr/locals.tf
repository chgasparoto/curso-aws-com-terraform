locals {
  app_name  = "${var.app_name}-${var.env}"
  file_hash = filemd5("${var.app_folder}/server.js")
}
