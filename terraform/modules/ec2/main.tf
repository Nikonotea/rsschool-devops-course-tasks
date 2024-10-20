resource "aws_instance" "bastion" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  key_name        = var.key_name
  security_groups = [var.bastion_sg_id]

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "k3s_master" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.private_subnet_id
  key_name        = var.key_name
  security_groups = [var.k3s_sg_id]

  user_data = <<-EOF
    #!/bin/bash
    curl -sfL https://get.k3s.io | sh -
  EOF

  tags = {
    Name = "k3s-master-node"
  }
}
