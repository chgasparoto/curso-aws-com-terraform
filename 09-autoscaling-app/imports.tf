# # import {
# #   to = aws_autoscaling_policy.cpu
# #   id = "${aws_autoscaling_group.this.name}/Target Tracking Policy - CPU"
# # }

# # import {
# #   to = aws_autoscaling_policy.load_balancer
# #   id = "${aws_autoscaling_group.this.name}/Target Tracking Policy - LB Req Count"
# # }

# import {
#   to = aws_launch_template.web
#   id = "lt-08b47f6e83247d420"
# }

# import {
#   to = aws_autoscaling_group.web
#   id = "as1"
# }

# import {
#   to = aws_autoscaling_policy.cpu
#   id = "as1/Target Tracking Policy - CPU"
# }

# import {
#   to = aws_lb.bar
#   id = "arn:aws:elasticloadbalancing:eu-central-1:871055234888:loadbalancer/app/as1-1/82dd181ddb9f3dbb"
# }

# import {
#   to = aws_lb_listener.front_end
#   id = "arn:aws:elasticloadbalancing:eu-central-1:871055234888:listener/app/as1-1/82dd181ddb9f3dbb/7bc3b90ffcbcf706"
# }

# import {
#   to = aws_lb_target_group.app_front_end
#   id = "arn:aws:elasticloadbalancing:eu-central-1:871055234888:targetgroup/as1-1/a559e23ce9fec2e7"
# }
