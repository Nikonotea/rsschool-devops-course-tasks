output "bastion_host_public_ip" {
  value       = aws_instance.bastion.public_ip
}

output "k3s_master_private_ip" {
  value       = aws_instance.k3s_master.private_ip
}