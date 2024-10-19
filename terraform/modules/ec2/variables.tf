variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "bastion_sg_id" {
  type = string
}

variable "k3s_sg_id" {
  type = string
}
