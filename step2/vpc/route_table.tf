# demo_public
resource "aws_route_table" "demo_public" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }

  tags = {
    Name = "demo-public"
  }
}

resource "aws_route_table_association" "demo_public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.demo_public.id
}

resource "aws_route_table_association" "demo_public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.demo_public.id
}