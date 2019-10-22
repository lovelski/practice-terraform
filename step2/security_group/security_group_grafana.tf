
resource "aws_security_group" "demo_grafana" {
  name        = "demo-grafana"
  description = "demo grafana"

  vpc_id = data.terraform_remote_state.vpc_data.outputs.demo_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-grafana"
  }
}

resource "aws_security_group_rule" "demo_grafana_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = ["119.206.206.251/32"]
  security_group_id = aws_security_group.demo_grafana.id

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "demo_grafana_web" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "TCP"
  cidr_blocks       = ["119.206.206.251/32"]
  security_group_id = aws_security_group.demo_grafana.id

  lifecycle { create_before_destroy = true }
}