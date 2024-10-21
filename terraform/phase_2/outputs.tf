output "bastion_host_public_ip" {
  value = module.ec2.bastion_host_public_ip
}

output "k3s_master_private_ip" {
  value       = module.ec2.k3s_master_private_ip
}
