resource "aws_launch_template" "this" {
  name_prefix   = local.namespaced_service_name
  image_id      = data.aws_ami.ubuntu.id # ami
  instance_type = var.instance_type
  key_name      = var.instance_keypair_name
  user_data     = filebase64("ec2_setup.sh")

  monitoring {
    enabled = true
  }

  network_interfaces {
    delete_on_termination = true
    security_groups       = [aws_security_group.autoscaling_group.id]
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = local.namespaced_service_name
  vpc_zone_identifier       = [aws_subnet.this["pub_a"].id, aws_subnet.this["pub_b"].id]
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 240 # 4 minutes
  health_check_type         = "ELB"
  force_delete              = true

  target_group_arns = [aws_alb_target_group.this.id]

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}

resource "aws_autoscaling_policy" "cpu" {
  enabled                = true
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

resource "aws_autoscaling_policy" "load_balancer" {
  enabled                = true
  name                   = "Target Tracking Policy - LB Req Count"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  target_tracking_configuration {
    disable_scale_in = false
    target_value     = 10

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${aws_alb.this.arn_suffix}/${aws_alb_target_group.this.arn_suffix}"
    }
  }
}
