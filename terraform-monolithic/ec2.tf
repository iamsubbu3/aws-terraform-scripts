################################################################################
# 1. PUBLIC INSTANCE 1 (e.g., Ansible/Jenkins Jump Server)
# Located in Public Subnet 1
################################################################################

resource "aws_instance" "public_instance-1" {
  ami                         = var.public_instance_ami_1
  instance_type               = var.public_instance_type_1
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
  key_name                    = var.public_instance_key_pair_1
  associate_public_ip_address = var.public_instance_associate_ip_add_1

  # Tip: You can uncomment for_each later if you want to scale to multiple tools
  # for_each = toset(["Ansible", "Jenkins"])

  # --- Storage Configuration Added Here ---
  root_block_device {
    volume_size = var.public_instance_volume_size_1
    volume_type = var.public_instance_volume_type_1 
  }

  tags = {
    Name = var.public_instance_name_1
    # Name = "${each.key}"
  }
}

################################################################################
# 2. PUBLIC INSTANCE 2
# Located in Public Subnet 2
################################################################################

resource "aws_instance" "public_instance-2" {
  ami                         = var.public_instance_ami_2
  instance_type               = var.public_instance_type_2
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public-subnet-2.id
  key_name                    = var.public_instance_key_pair_2
  associate_public_ip_address = var.public_instance_associate_ip_add_2

  root_block_device {
    volume_size = var.public_instance_volume_size_2
    volume_type = var.public_instance_volume_type_2 
  }

  tags = {
    Name = var.public_instance_name_2
  }
}

################################################################################
# 3. PUBLIC INSTANCE 3
# Located in Public Subnet 3
################################################################################

resource "aws_instance" "public_instance-3" {
  ami                         = var.public_instance_ami_3
  instance_type               = var.public_instance_type_3
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public-subnet-3.id
  key_name                    = var.public_instance_key_pair_3
  associate_public_ip_address = var.public_instance_associate_ip_add_3

  root_block_device {
    volume_size = var.public_instance_volume_size_3
    volume_type = var.public_instance_volume_type_3 
  }

  tags = {
    Name = var.public_instance_name_3
  }
}