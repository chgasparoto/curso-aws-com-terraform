resource "aws_ecs_cluster" "this" {
  name = "${local.app_name}-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${local.app_name}-task-definition"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory

  container_definitions = templatefile("${path.module}/${var.env}/template-container-definition.json", {
    app_image      = aws_ecr_repository.this.repository_url
    app_name       = local.app_name
    container_name = local.container_name
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.region
    env            = var.env == "prod" ? "production" : var.env
  })
}

resource "aws_ecs_service" "this" {
  name            = "${local.app_name}-service"
  task_definition = aws_ecs_task_definition.this.arn
  cluster         = aws_ecs_cluster.this.id
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.private.*.id
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.id
    container_name   = local.container_name
    container_port   = var.app_port
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_alb_listener.this]
}