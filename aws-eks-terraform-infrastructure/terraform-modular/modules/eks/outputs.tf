################################################################################
# 1. CLUSTER CONNECTION DETAILS
# Used to configure kubectl and connect to the Kubernetes API server.
################################################################################

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS Kubernetes API server."
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster."
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_version" {
  description = "Kubernetes version of the EKS cluster."
  value       = aws_eks_cluster.main.version
}

################################################################################
# 2. IDENTITY & SECURITY
################################################################################

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL used for IAM Roles for Service Accounts (IRSA)."
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "cluster_arn" {
  description = "ARN of the EKS Cluster."
  value       = aws_eks_cluster.main.arn
}

################################################################################
# 3. OIDC PROVIDER (REQUIRED FOR ALB CONTROLLER)
################################################################################

output "oidc_provider_arn" {
  description = "OIDC Provider ARN for IRSA roles (ALB Controller etc)"
  value       = aws_iam_openid_connect_provider.oidc.arn
}
