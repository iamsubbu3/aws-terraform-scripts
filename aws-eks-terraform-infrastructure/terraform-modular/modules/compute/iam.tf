################################################################################
# IAM ROLE FOR MANAGEMENT / BASTION INSTANCE
################################################################################

resource "aws_iam_role" "ec2_role" {
  name = "ec2-management-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

################################################################################
# REQUIRED POLICIES (BEST PRACTICE SET)
################################################################################

# Allows SSM Session Manager access (NO SSH needed if you want)
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Allows interacting with EKS cluster (Describe, kubeconfig, etc.)
resource "aws_iam_role_policy_attachment" "eks_describe" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_describe_worker_node" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Optional but VERY useful for DevOps node (ECR pulls, etc)
resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

################################################################################
# INSTANCE PROFILE (ATTACHED TO ONLY ONE INSTANCE)
################################################################################

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-management-instance-profile"
  role = aws_iam_role.ec2_role.name
}
