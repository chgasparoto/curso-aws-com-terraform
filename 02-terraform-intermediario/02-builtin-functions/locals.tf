locals {
  instance_number = lookup(var.instance_number, var.environment)

  file_ext    = "zip"
  object_name = "meu-arquivo-gerado-de-um-template"

  common_tags = {
    "Owner" = "Cleber Gasparoto"
    "Year"  = "2023"
  }
}
