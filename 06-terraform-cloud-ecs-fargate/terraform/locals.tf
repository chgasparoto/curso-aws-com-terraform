locals {
  app_name                = "${var.app_name}-${var.env}"
  container_name          = "${local.app_name}-container"
  autoscaling_resource_id = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"

  tags = {
    Project   = local.app_name
    Env       = var.env
    ManagedBy = "Terraform"
    Owner     = "Cleber Gasparoto"
  }
}