resource "aws_lb" "main" {
  name               = "${var.name}-${var.env}"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnets
  security_groups    = [aws_security_group.main.id]

  enable_deletion_protection = var.enable_deletion_protection
  
  tags = merge(
    var.tags,
    { Name = "${var.name}-${var.env}" }
  )
}

# lb listener

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<center><h1>503 - Not accessible</h1></center>"
      status_code  = "503"
    }
  }
}


resource "aws_security_group" "main" {
  name        = "${var.name}-${var.env}-lb"
  description = "${var.name}-${var.env}-lb"
  vpc_id      = var.vpc_id

  ingress {
    description      = "APP"
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = var.allow_cidr

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-${var.env}-lb" }
  )
}