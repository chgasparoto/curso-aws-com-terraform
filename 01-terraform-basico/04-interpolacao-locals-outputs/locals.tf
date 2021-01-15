locals {
  service_name = substr("ilo-${var.environment}-123654987", 0, 62)
  ip_filepath  = "ips.json"

  common_tags = {
    Service     = "Curso Terraform"
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = "Cleber Gasparoto"
  }
}
