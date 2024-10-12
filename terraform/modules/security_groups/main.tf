resource "aws_security_group" "public" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow all inbound traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic to anywhere
  }

  tags = {
    Name = "Public Security Group"
  }
}

resource "aws_security_group" "private" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    security_groups = [aws_security_group.public.id]  # Allow inbound traffic from the public security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic to anywhere
  }

  tags = {
    Name = "Private Security Group"
  }
}
