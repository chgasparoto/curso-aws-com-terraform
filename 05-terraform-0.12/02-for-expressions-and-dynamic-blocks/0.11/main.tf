resource "aws_autoscaling_group" "example" {
  tag {
    key                 = "Name"
    value               = "example-asg-name"
    propagate_at_launch = false
  }

  tag {
    key                 = "Component"
    value               = "user-service"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "production"
    propagate_at_launch = true
  }
}
