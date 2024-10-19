variable "cidr_block" {
  type    = string
}

variable "public_subnet_count" {
  type    = number
}

variable "private_subnet_count" {
  type    = number
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

