# ################################################################################
# # 1. CLUSTER CONNECTION DETAILS
# # Use these to configure your local kubectl and connect to the cluster.
# ################################################################################

# output "cluster_name" {
#   description = "The name of the EKS cluster."
#   value       = aws_eks_cluster.eks-cluster.name
# }

# output "endpoint" {
#   description = "The endpoint for your EKS Kubernetes API."
#   value       = aws_eks_cluster.eks-cluster.endpoint
# }

# output "cluster_certificate_authority_data" {
#   description = "Base64 encoded certificate data required to communicate with the cluster."
#   value       = aws_eks_cluster.eks-cluster.certificate_authority[0].data
# }

# ################################################################################
# # 2. INFRASTRUCTURE METADATA
# # General information about where your resources are located.
# ################################################################################

# output "region" {
#   description = "The AWS region where the cluster is deployed."
#   value       = var.aws_region
# }

# ################################################################################
# # 3. SECURITY & IDENTITY
# # Used for setting up IAM Roles for Service Accounts (IRSA).
# ################################################################################

# output "cluster_oidc_issuer_url" {
#   description = "The URL on the EKS cluster for the OpenID Connect identity provider."
#   value       = aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
# }