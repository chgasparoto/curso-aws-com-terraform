resource "aws_security_group" "alb" {
  name        = "${local.namespaced_service_name}-aalb"
  description = "Allows hhtp and egress traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.internet_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.internet_cidr_block]
  }

  tags = {
    "Name" = "${local.namespaced_service_name}-alb"
  }
}

resource "aws_security_group" "autoscaling_group" {
  name        = "${local.namespaced_service_name}-autoscaling-group"
  description = "Allows ssh/hhtp and egress traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.internet_cidr_block]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [local.internet_cidr_block]
  }

  tags = {
    "Name" = "${local.namespaced_service_name}-autoscaling-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "${local.namespaced_service_name}-rds"
  description = "Allows incoming database connections"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.autoscaling_group.id]
  }

  tags = {
    "Name" = "${local.namespaced_service_name}-rds"
  }
}

resource "aws_security_group" "jenkins" {
  name        = "${local.namespaced_service_name}-jenkins"
  description = "Allows ssh traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.autoscaling_group.id]
  }

  tags = {
    "Name" = "${local.namespaced_service_name}-jenkins"
  }
}
