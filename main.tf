resource "aws_launch_configuration" "web-server" {
    image_id           =  "ami-01387af90a62e3c01"
    instance_type = "t2.micro"
    key_name = "docker"
}
   


  resource "aws_elb" "aws_elb"{
     name = "web-server-lb"
     security_groups = [aws_security_group.web_server.id]
     subnets = ["subnet-0faae7713f4e2f438", "subnet-0fcfbc8b256444488"]
     listener {
      instance_port     = 8000
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
    tags = {
      Name = "terraform-elb"
    }
  }
resource "aws_autoscaling_group" "web-server-asg" {
    name                 = "web-server-asg"
    launch_configuration = aws_launch_configuration.web_server.name
    min_size             = 1
    max_size             = 3
    desired_capacity     = 2
    health_check_type    = "EC2"
    load_balancers       = [aws_elb.aws_elb.name]
    availability_zones    = ["us-esat-2a", "us-east-2b"] 
    
  }
