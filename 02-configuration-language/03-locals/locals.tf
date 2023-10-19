locals {
  namespaced_service_name = "${var.service_name}-${var.environment}"

  required_tags = {
    Service     = var.service_name
    Environment = var.environment
  }

  common_tags = merge(var.tags, local.required_tags)
}
