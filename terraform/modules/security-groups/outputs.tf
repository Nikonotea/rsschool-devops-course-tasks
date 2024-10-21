output "bastion_sg_id" {
  description = "The ID of the Bastion host security group"
  value       = aws_security_group.bastion_sg.id 
}

output "k3s_sg_id" {
  description = "The ID of the K3s cluster security group"
  value       = aws_security_group.k3s_sg.id
}
