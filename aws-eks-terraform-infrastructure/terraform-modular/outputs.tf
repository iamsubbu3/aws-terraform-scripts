################################################################################
# 1. CLUSTER CONNECTION DETAILS
################################################################################

output "cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data."
  value       = module.eks.cluster_certificate_authority_data
}

################################################################################
# 2. INFRASTRUCTURE METADATA
################################################################################

output "region" {
  description = "AWS region"
  value       = var.aws_region
}

################################################################################
# 3. SECURITY & IDENTITY
################################################################################

output "cluster_oidc_issuer_url" {
  description = "OIDC Issuer URL"
  value       = module.eks.cluster_oidc_issuer_url
}

################################################################################
# 4. MANAGEMENT INSTANCE ACCESS
################################################################################

output "public_instance_ips" {
  description = "Public IPs of EC2 instances"
  value       = module.compute.public_ips
}

output "public_instance_dns" {
  description = "Public DNS of EC2 instances"
  value       = module.compute.public_dns
}
