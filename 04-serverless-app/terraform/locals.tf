locals {
  layer_name   = "layer.zip"
  layers_path  = "${path.module}/../app/layers/nodejs"
  lambdas_path = "${path.module}/../app/lambdas"

  common_tags = {
    Project   = "TODO Serverless App"
    CreatedAt = "2020-02-01"
    ManagedBy = "Terraform"
    Owner     = "Cleber Gasparoto"
    Service   = var.service_name
  }
}
