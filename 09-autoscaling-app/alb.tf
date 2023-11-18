resource "aws_lb" "this" {
  name               = local.namespaced_service_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.this["pub_a"].id, aws_subnet.this["pub_b"].id]

  tags = {
    Name = local.namespaced_service_name
  }
}

resource "aws_lb_target_group" "this" {
  name     = local.namespaced_service_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id

  health_check {
    path              = "/"
    healthy_threshold = 2
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
