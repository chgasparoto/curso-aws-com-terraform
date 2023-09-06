data "archive_file" "json" {
  type        = local.file_ext
  output_path = "${path.module}/files/${local.object_name}.${local.file_ext}"

  source {
    content = templatefile("template.json.tpl", {
      age    = 33
      eye    = "Brown"
      name   = "Cleber"
      gender = "Male"
    })
    filename = "${local.object_name}.json"
  }
}
