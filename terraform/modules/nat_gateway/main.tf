resource "aws_eip" "nat" {
  domain = "vpc"  # Change this line
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id    = var.public_subnet_id

  tags = {
    Name = "NAT Gateway"
  }
}
