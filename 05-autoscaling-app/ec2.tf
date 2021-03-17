resource "aws_launch_configuration" "this" {
  name_prefix                 = "autoscaling-launcher"
  image_id                    = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  security_groups             = [aws_security_group.autoscaling.id]
  associate_public_ip_address = true

  user_data = file("ec2_setup.sh")
}

resource "aws_autoscaling_group" "this" {
  name                      = "terraform-autoscaling"
  vpc_zone_identifier       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  launch_configuration      = aws_launch_configuration.this.name
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.this.arn]
  enabled_metrics           = var.enabled_metrics
}

resource "aws_autoscaling_policy" "scaleup" {
  name                   = "Scale Up"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_autoscaling_policy" "scaledown" {
  name                   = "Scale Down"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_instance" "jenkins" {
  ami           = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.db.id]
  subnet_id              = aws_subnet.private_b.id
  availability_zone      = "${var.aws_region}b"

  tags = merge(local.common_tags, { Name = "Jenkins Machine" })
}
