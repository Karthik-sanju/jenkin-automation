resource "aws_launch_configuration" "web-server" {
  image_id      = "ami-019f9b3318b7155c5"
  instance_type = "t2.micro"
  key_name      = "docker.pem"

}
resource "aws_elb" "aws_elb" {
  name            = "web-server-lb"
  security_groups = [aws_security_group.web_server.id]
  subnets         = ["subnet-0faae7713f4e2f438", "subnet-0fcfbc8b256444488"]
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  tags = {
    name = "terraform-elb"
  }

}

resource "aws_autoscaling_group" "web-server-asg" {
  name                 = "web-server-asg"
  launch_configuration = aws_launch_configuration.web-server.name
  max_size             = 3
  min_size             = 1
  desired_capacity     = 2
  health_check_type    = "EC2"
  load_balancers       = [aws_elb.aws_elb.name]
availability_zones   = ["us-east-2a, us-east-2b"]

}