#  Launch template for Web tier AutoScaling Group
resource "aws_launch_template" "Web-LC" {
  name = var.launch-template-name
  image_id = data.aws_ami.ami.image_id
  instance_type = "t2.micro"

  vpc_security_group_ids = [data.aws_security_group.web-sg.id]

  user_data = file("${path.module}/deploy.sh")
}

# Autoscaling for the Web Tier
resource "aws_autoscaling_group" "web-tier-asg" {
  name                      = var.web-asg-name
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  target_group_arns = [data.aws_lb_target_group.tg.arn]
  force_delete              = true

  launch_template {
    id = aws_launch_template.Web-LC.id
    version = aws_launch_template.Web-LC.latest_version
  }

  tag {
    key                 = "Name"
    value               = var.web-asg-name
    propagate_at_launch = true
  }
}

# Auto scaling policy for cpu
resource "aws_autoscaling_policy" "web-custom-cpu-policy" {
  name                   = "custom-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.web-tier-asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "web-custom-cpu-alarm" {
  alarm_name                = "web-custom-cpu-alarm"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 70
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.web-custom-cpu-policy.arn]

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.web-tier-asg.name
  }
}

# Auto scaling policy for cpu scaledown
resource "aws_autoscaling_policy" "web-custom-cpu-scaledown-policy" {
  name                   = "custom-cpu-scaledown-policy"
  autoscaling_group_name = aws_autoscaling_group.web-tier-asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "web-custom-cpu-scaledown-alarm" {
  alarm_name                = "web-custom-cpu-scaledown-alarm"
  alarm_description         = "This metric monitors ec2 cpu utilization and scales down"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 50
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.web-custom-cpu-policy.arn]

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.web-tier-asg.name
  }
}