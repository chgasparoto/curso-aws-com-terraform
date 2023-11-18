# resource "aws_security_group" "web" {
#   name        = "Web"
#   description = "Allow public inbound traffic"
#   vpc_id      = aws_vpc.this.id

#   ingress {
#     from_port   = 80 # http
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = [local.internet_cidr_block]
#   }

#   ingress {
#     from_port   = 443 # https
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [local.internet_cidr_block]
#   }

#   egress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = [aws_subnet.this["pvt_b"].cidr_block]
#   }

#   tags = {
#     "Name" = "Web Server"
#   }
# }

# resource "aws_security_group" "db" {
#   name        = "DB"
#   description = "Allow incoming database connections"
#   vpc_id      = aws_vpc.this.id

#   ingress {
#     from_port       = 3306 # mysql
#     to_port         = 3306
#     protocol        = "tcp"
#     security_groups = [aws_security_group.web.id]
#   }

#   ingress {
#     from_port   = 22 # ssh
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [aws_vpc.this.cidr_block]
#   }

#   egress {
#     from_port   = 80 # http
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = [local.internet_cidr_block]
#   }

#   egress {
#     from_port   = 443 # https
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [local.internet_cidr_block]
#   }

#   tags = {
#     "Name" = "MySQL Database"
#   }
# }

resource "aws_security_group" "alb" {
  name        = "${local.namespaced_service_name}-alb"
  description = "Allows public inbound traffic"
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
  description = "Allows ssh/http and all egress traffic"
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
