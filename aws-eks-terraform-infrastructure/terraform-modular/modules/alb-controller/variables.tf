################################################################################
# ALB CONTROLLER REQUIRED VARIABLES
################################################################################

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB will be created"
  type        = string
}

################################################################################
# IRSA (OIDC) CONFIGURATION
################################################################################

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN from EKS module"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC Provider URL (issuer)"
  type        = string
}
