provider "aws" {
  region     = var.region
}

resource "aws_launch_configuration" "launch_config" {
  name          = "web_config"
  image_id      = lookup(var.ami_id, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name
  security_groups = [ var.security_grpup_id]
}

resource "aws_autoscaling_group" "example_autoscaling" {
  name                      = "autoscaling-terraform-test"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch_config.name
  availability_zones        = ["us-east-1a","us-east-1b"]
  # vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

}

resource "aws_autoscaling_policy" "asp" {
  name                   = "asp-terraform-test"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.example_autoscaling.name
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm" {
  alarm_name                = "terraform-test-cloudwatch"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  
   dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.example_autoscaling.name
  }
  
    actions_enabled     = true
    alarm_actions     = [aws_autoscaling_policy.asp.arn]

}

resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
  display_name = "example auto scaling"
}

resource "aws_autoscaling_notification" "example_notifications" {
  group_names = [aws_autoscaling_group.example_autoscaling.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.user_updates.arn
}