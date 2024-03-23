resource "aws_security_group" "web_server" {
  name = "web_server-sg"
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
variable "ports" {
  description = "this has port valus"
  type        = list(any)
  default     = [22, 80, 443]

}