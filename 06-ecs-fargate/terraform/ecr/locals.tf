locals {
  app_name  = "${var.app_name}-${var.env}"
  file_hash = sha1(join("", [for f in fileset(var.app_folder, "*"): filesha1("${var.app_folder}/${f}")]))

}
