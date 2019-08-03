output "repository_name" {
  value = aws_ecr_repository.this.name
}

output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
}

output "ecs_service_id" {
  value = aws_ecs_service.this.id
}

output "alb_url" {
  value = aws_alb.this.dns_name
}

output "log_group" {
  value = aws_cloudwatch_log_group.this.arn
}