resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.app_name}"
  retention_in_days = var.log_retention

  tags = merge({ Name = "${local.app_name}-log-group" }, local.tags)
}

//resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
//  alarm_name          = "${local.app_name}_cpu_utilization_high"
//  comparison_operator = "GreaterThanOrEqualToThreshold"
//  evaluation_periods  = "2"
//  metric_name         = "CPUUtilization"
//  namespace           = "AWS/ECS"
//  period              = "60"
//  statistic           = "Average"
//  threshold           = "85"
//
//  dimensions = {
//    ClusterName = aws_ecs_cluster.this.name
//    ServiceName = aws_ecs_service.this.name
//  }
//
//  alarm_actions = [aws_appautoscaling_policy.up.arn]
//}
//
//resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
//  alarm_name          = "${local.app_name}_cpu_utilization_low"
//  comparison_operator = "LessThanOrEqualToThreshold"
//  evaluation_periods  = "2"
//  metric_name         = "CPUUtilization"
//  namespace           = "AWS/ECS"
//  period              = "60"
//  statistic           = "Average"
//  threshold           = "10"
//
//  dimensions = {
//    ClusterName = aws_ecs_cluster.this.name
//    ServiceName = aws_ecs_service.this.name
//  }
//
//  alarm_actions = [aws_appautoscaling_policy.down.arn]
//}
