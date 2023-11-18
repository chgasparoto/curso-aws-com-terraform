resource "aws_launch_template" "this" {
  name_prefix   = local.namespaced_service_name
  image_id      = var.instance_config.ami
  instance_type = var.instance_config.type
  key_name      = var.instance_config.key_name
  user_data     = filebase64("ec2_setup.sh")

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination       = true
    associate_public_ip_address = true
    security_groups             = [aws_security_group.autoscaling_group.id]
  }
}

resource "aws_autoscaling_group" "this" {
  name = local.namespaced_service_name

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 4
  health_check_grace_period = 240 # 4 minutes
  health_check_type         = "ELB"
  force_delete              = true

  target_group_arns   = [aws_alb_target_group.this.id]
  vpc_zone_identifier = [aws_subnet.this["pub_a"].id, aws_subnet.this["pub_b"].id]

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}

resource "aws_autoscaling_policy" "cpu" {
  enabled                = false
  name                   = "Target Tracking Policy - CPU"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  target_tracking_configuration {
    disable_scale_in = false
    target_value     = 50

    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}

# resource "aws_autoscaling_policy" "load_balancer" {
#   enabled                = false
#   name                   = "Target Tracking Policy - LB Req Count"
#   policy_type            = "TargetTrackingScaling"
#   autoscaling_group_name = aws_autoscaling_group.this.name

#   target_tracking_configuration {
#     disable_scale_in = false
#     target_value     = 10

#     predefined_metric_specification {
#       predefined_metric_type = "ALBRequestCountPerTarget"
#       resource_label         = "${aws_alb.this.arn_suffix}/${aws_alb_target_group.this.arn_suffix}"
#     }
#   }
# }
