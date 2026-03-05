################################################################################
# 1. EKS CLUSTER (CONTROL PLANE)
################################################################################

variable "cluster_name" {
  description = "Name of the EKS Cluster."
  type        = string
}

variable "cluster_role" {
  description = "IAM Role name used by the EKS Control Plane."
  type        = string
}

variable "all_subnet_ids" {
  description = "All subnet IDs (public + private) used by the cluster."
  type        = list(string)
}

variable "node_security_group_id" {
  description = "Security Group attached to EKS control plane."
  type        = string
}

variable "my_ip" {
  description = "CIDR allowed to access EKS public API."
  type        = string
}

################################################################################
# 2. NODE GROUP (DATA PLANE)
################################################################################

variable "node_group_name" {
  description = "Name of the EKS Managed Node Group."
  type        = string
}

variable "node_role" {
  description = "IAM Role name assigned to worker nodes."
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs where worker nodes will be launched."
  type        = list(string)
}

################################################################################
# 3. NODE INSTANCE SETTINGS
################################################################################

variable "capacity_type" {
  description = "Capacity type for nodes (ON_DEMAND or SPOT)."
  type        = string
}

variable "instance_types" {
  description = "Instance types for node group."
  type        = list(string)
}

variable "disk_size" {
  description = "Root disk size (GiB)."
  type        = number
}

################################################################################
# 4. AUTO SCALING CONFIGURATION
################################################################################

variable "desired_size" {
  description = "Desired node count."
  type        = number
}

variable "max_size" {
  description = "Maximum node count."
  type        = number
}

variable "min_size" {
  description = "Minimum node count."
  type        = number
}
