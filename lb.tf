resource "aws_lb" "lb" {
  name               = format("%s-lb", var.prefix)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in module.vpc.private_subnets : subnet]
  //subnets          = private_subnet_ids
  enable_deletion_protection = true

  #   access_logs {
  #     bucket  = aws_s3_bucket.lb_logs.id
  #     prefix  = "test-lb"
  #     enabled = true
  #   }

  tags = {
    Name = format("%s-lb", var.prefix)
  }
}
resource "aws_lb_target_group" "tg" {
  name     = format("%s-tg", var.prefix)
  port     = 8000
  protocol = "HTTP"
  //vpc_id      = aws_vpc.vpc.id
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200,302"
    path                = "/users"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }
}
resource "aws_lb_listener" "tg-listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
resource "aws_security_group" "lb_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  //vpc_id      = aws_vpc.vpc.id
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = format("%s-lb-sg", var.prefix)
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8000
    to_port   = 8000
    protocol  = "tcp"
    self      = true
  }
}

  