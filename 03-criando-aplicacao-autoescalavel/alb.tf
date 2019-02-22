resource "aws_security_group" "alb" {
  name        = "ALB-SG"
  description = "Load Balancer SG"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Load Balancer"
  }
}

resource "aws_lb" "lb" {
  name            = "ALB"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["${aws_subnet.public_a.id}", "${aws_subnet.public_b.id}"]

  tags {
    Name = "ALB"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"

  health_check = {
    path              = "/"
    healthy_threshold = 2
  }
}

resource "aws_lb_listener" "lbl" {
  load_balancer_arn = "${aws_lb.lb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tg.arn}"
  }
}
