resource "aws_security_group" "demo" {
  name        = "demo"
  description = "demo server"

  vpc_id = data.terraform_remote_state.vpc_data.outputs.demo_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo"
  }
}

resource "aws_security_group_rule" "demo_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["119.206.206.251/32"]
  security_group_id = aws_security_group.demo.id

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "demo_rdp" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "TCP"
  cidr_blocks       = ["119.206.206.251/32"]
  security_group_id = aws_security_group.demo.id

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "demo_winrm" {
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "TCP"
  cidr_blocks       = ["119.206.206.251/32"]
  security_group_id = aws_security_group.demo.id

  lifecycle { create_before_destroy = true }
}
