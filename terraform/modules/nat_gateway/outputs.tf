output "nat_gateway_allocation_id" {
  value = aws_eip.nat.id
}

output "nat_ip" {
  value = aws_nat_gateway.main.id
}
