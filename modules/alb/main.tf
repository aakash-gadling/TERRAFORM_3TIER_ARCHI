# Create Application Load Balancer

resource "aws_lb" "application_lb" {
    name = "application-lb"
    internal = false
    load_balancer_type = "application"
    security_groups    = [var.security_group_id]
    subnets            = [var.public_subnet_az1_id, var.public_subnet_az2_id]
    # depends_on = [aws_instance.webserver1, aws_instance.webserver2]
  
}

resource "aws_lb_listener" "application_lb_list" {
    load_balancer_arn = aws_lb.application_lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.application_lb_tg.arn
    }
  
}

resource "aws_lb_target_group" "application_lb_tg" {
    name = "application-lb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "instance"
    tags = {
        Name = "application-lb-tg"
    }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
    autoscaling_group_name = "web_asg"
    lb_target_group_arn = aws_lb_target_group.application_lb_tg.arn
  
}