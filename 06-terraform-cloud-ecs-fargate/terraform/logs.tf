resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.app_name}"
  retention_in_days = 5

  tags = {
    Name = "${local.app_name}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "${local.app_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}