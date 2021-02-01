locals {
  common_tags = {
    Project   = "TODO Serverless App"
    CreatedAt = "2020-02-01"
    ManagedBy = "Terraform"
    Owner     = "Cleber Gasparoto"
    Service   = var.service_name
  }
}
