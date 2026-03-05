################################################################################
# SECURITY GROUP DEFINITION
# Firewall for EC2 instances, Jenkins, Ansible and EKS worker nodes
################################################################################

resource "aws_security_group" "sg" {

  name        = var.sg_name
  description = "Security group for EC2, Jenkins, Ansible and EKS"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_name
  }

  ################################################################################
  # INBOUND RULES
  ################################################################################

  # SSH from your laptop
  ingress {
    description = "SSH from Admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # SSH between instances (Jenkins ↔ Ansible ↔ Nodes)
  ingress {
    description = "SSH between instances"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = true
  }

  # REQUIRED FOR EKS NODE ↔ CONTROL PLANE COMMUNICATION
  ingress {
    description = "Allow all internal cluster communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # EKS API Access (kubectl / eksctl)
  ingress {
    description = "EKS API Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.eks_jump_server]
  }

  # Web / Jenkins / SonarQube
  ingress {
    description = "Web Traffic"
    from_port   = 80
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ################################################################################
  # OUTBOUND RULES
  ################################################################################

  egress {
    description = "Allow all outbound internet access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
