variable "ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "bastion_sg_id" {
  description = "Security Group ID for the Bastion host"
  type        = string
}

variable "k3s_sg_id" {
  description = "Security Group ID for the K3s cluster"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID for the EC2 instance"
  type        = string
}
