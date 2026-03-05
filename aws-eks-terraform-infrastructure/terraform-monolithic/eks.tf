# ################################################################################
# # 1. DATA SOURCES & IDENTITY
# # These blocks fetch information about your AWS account and EKS certificates.
# ################################################################################

# data "aws_caller_identity" "current" {}

# data "tls_certificate" "eks" {
#   url = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
# }

# # The Trust Relationship for Service Accounts (IRSA)
# data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
#       values   = ["system:serviceaccount:default:my-app-sa"]
#     }

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:aud"
#       values   = ["sts.amazonaws.com"]
#     }

#     principals {
#       identifiers = [aws_iam_openid_connect_provider.eks.arn]
#       type        = "Federated"
#     }
#   }
# }

# ################################################################################
# # 2. EKS CLUSTER (CONTROL PLANE)
# # This creates the main EKS cluster and its required IAM role.
# ################################################################################

# resource "aws_eks_cluster" "eks-cluster" {
#   name     = var.eks-cluster_name
#   role_arn = aws_iam_role.eks-cluster-role.arn
#   version  = "1.35"

#   access_config {
#     authentication_mode = "API"
#   }

#   vpc_config {
#     subnet_ids = [
#       aws_subnet.public-subnet-1.id,
#       aws_subnet.private-subnet-1.id,
#       aws_subnet.public-subnet-2.id,
#       aws_subnet.private-subnet-2.id,
#       aws_subnet.public-subnet-3.id,
#       aws_subnet.private-subnet-3.id,
#     ]
#     endpoint_private_access = true
#     endpoint_public_access  = false
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
#   ]
# }

# resource "aws_iam_role" "eks-cluster-role" {
#   name = var.eks-cluster_role_name
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = ["sts:AssumeRole", "sts:TagSession"]
#       Effect    = "Allow"
#       Principal = { Service = "eks.amazonaws.com" }
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks-cluster-role.name
# }

# ################################################################################
# # 3. ACCESS & SECURITY (OIDC)
# # Configures how you and your applications log into the cluster.
# ################################################################################

# # Grant the creator (you) full Admin rights using the new API mode
# resource "aws_eks_access_entry" "admin" {
#   cluster_name      = aws_eks_cluster.eks-cluster.name
#   principal_arn     = data.aws_caller_identity.current.arn
#   kubernetes_groups = ["system:masters"]
#   type              = "STANDARD"
# }

# # The OIDC Identity Provider for the cluster
# resource "aws_iam_openid_connect_provider" "eks" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
#   url             = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
# }

# # The IAM Role your specific Kubernetes application will use
# resource "aws_iam_role" "eks_oidc" {
#   assume_role_policy = data.aws_iam_policy_document.eks_oidc_assume_role_policy.json
#   name               = "eks-oidc-app-role"
# }

# ################################################################################
# # 4. WORKER NODES (DATA PLANE)
# # Launches the EC2 instances that run your actual applications.
# ################################################################################

# resource "aws_eks_node_group" "private-nodes" {
#   cluster_name    = aws_eks_cluster.eks-cluster.name
#   node_group_name = var.node_group_name
#   node_role_arn   = aws_iam_role.nodes-role.arn
#   subnet_ids      = [
#     aws_subnet.private-subnet-1.id,
#     aws_subnet.private-subnet-2.id,
#     aws_subnet.private-subnet-3.id
#   ]

#   capacity_type  = var.node_instance_capacity_type
#   instance_types = [var.node_instance_type]
#   disk_size      = var.node_disk_size

#   labels = {
#     type      = var.node_instance_capacity_type_label_name
#     lifecycle = var.node_instance_capacity_lifecycle_label_name
#   }

#   scaling_config {
#     desired_size = var.node_desired_size
#     max_size     = var.node_max_size
#     min_size     = var.node_min_size
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
#     aws_iam_role_policy_attachment.nodes-AmazonEBSCSIDriverPolicy
#   ]
# }

# # IAM Role and Policies for the Worker Nodes
# resource "aws_iam_role" "nodes-role" {
#   name = var.eks-node-group-role-name
#   assume_role_policy = jsonencode({
#     Version   = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Effect    = "Allow"
#       Principal = { Service = "ec2.amazonaws.com" }
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.nodes-role.name
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.nodes-role.name
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.nodes-role.name
# }

# resource "aws_iam_role_policy_attachment" "nodes-AmazonEBSCSIDriverPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
#   role       = aws_iam_role.nodes-role.name
# }

# ################################################################################
# # 5. EKS ADD-ONS
# # Standard AWS tools for networking and DNS inside the cluster.
# ################################################################################

# resource "aws_eks_addon" "vpc-cni" {
#   cluster_name = aws_eks_cluster.eks-cluster.name
#   addon_name   = "vpc-cni"
# }

# resource "aws_eks_addon" "coredns" {
#   cluster_name = aws_eks_cluster.eks-cluster.name
#   addon_name   = "coredns"
# }

# resource "aws_eks_addon" "kube-proxy" {
#   cluster_name = aws_eks_cluster.eks-cluster.name
#   addon_name   = "kube-proxy"
# }