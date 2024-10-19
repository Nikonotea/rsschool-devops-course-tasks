variable "region" {
  description = "AWS region"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of AXs for subnets"
  type        = list(string)
}

variable "ami" {
  description = "AMI for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2"
  type        = string
}

variable "key_name" {
  description = "Name of SSH key for access to EC2 instances"
  type        = string
}
