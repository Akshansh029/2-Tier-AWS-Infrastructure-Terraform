# Creating Load balancer for Web tier
resource "aws_lb" "web-tier-alb" {
  name = var.web-alb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.web-alg-sg.id]
  subnets            = [data.aws_subnet.public-subnet1.id, data.aws_subnet.public-subnet2.id]
  ip_address_type = "ipv4"
  enable_deletion_protection = true

  tags = {
      Name = var.web-alb-name
  }
}

# Target group for ALB
resource "aws_lb_target_group" "alg-tg" {
  name     = var.web-alb-tg-name
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id

  health_check {
    enabled = true
    interval = 10
    path = "/"
    protocol = "HTTP"
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = var.web-alb-tg-name
  }

  lifecycle {
    prevent_destroy = false
  }

  depends_on = [ aws_lb.web-tier-alb ]
}

# ALB Listener with port 80 and attaching to web-tier target group
resource "aws_lb_listener" "web-tier-alb-listener" {
  load_balancer_arn = aws_lb.web-tier-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alg-tg.arn
  }

  depends_on = [ aws_lb.web-tier-alb, aws_lb_target_group.alg-tg ]
}