resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.app_name}"
  retention_in_days = var.log_retention

  tags = merge({ Name = "${local.app_name}-log-group" }, local.tags)
}
