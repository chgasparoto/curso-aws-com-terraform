resource "aws_alb" "this" {
  name               = local.namespaced_service_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = local.public_subnet_ids

  tags = {
    "Name" = local.namespaced_service_name
  }
}

resource "aws_alb_target_group" "http" {
  name     = local.namespaced_service_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id

  health_check {
    enabled             = var.alb_healthcheck_config.enabled
    healthy_threshold   = var.alb_healthcheck_config.healthy_threshold
    interval            = var.alb_healthcheck_config.interval
    matcher             = var.alb_healthcheck_config.matcher
    path                = var.alb_healthcheck_config.path
    port                = var.alb_healthcheck_config.port
    protocol            = var.alb_healthcheck_config.protocol
    timeout             = var.alb_healthcheck_config.timeout
    unhealthy_threshold = var.alb_healthcheck_config.unhealthy_threshold
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.http.arn
  }

}
