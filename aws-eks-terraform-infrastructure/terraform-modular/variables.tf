################################################################################
# 1. GLOBAL SETTINGS
################################################################################

variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
}

################################################################################
# 2. VPC & NETWORKING
################################################################################

variable "vpc_name" {
  description = "Name tag for the VPC."
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "instance_tenancy" {
  description = "Instance tenancy for the VPC."
  type        = string
  default     = "default"
}

# Public Subnets
variable "public_subnet_1_cidr_block" { type = string }
variable "public_subnet_1_avail_zone" { type = string }

variable "public_subnet_2_cidr_block" { type = string }
variable "public_subnet_2_avail_zone" { type = string }

variable "public_subnet_3_cidr_block" { type = string }
variable "public_subnet_3_avail_zone" { type = string }

# Private Subnets (EKS Worker Nodes)
variable "private_subnet_1_cidr_block" { type = string }
variable "private_subnet_1_avail_zone" { type = string }

variable "private_subnet_2_cidr_block" { type = string }
variable "private_subnet_2_avail_zone" { type = string }

variable "private_subnet_3_cidr_block" { type = string }
variable "private_subnet_3_avail_zone" { type = string }

################################################################################
# 3. SECURITY
################################################################################

variable "sg_name" {
  description = "Security Group name."
  type        = string
}

variable "my_ip" {
  description = "Your public IP in CIDR format."
  type        = string
}

variable "eks_jump_server" {
  description = "CIDR allowed for EKS API access."
  type        = string
}

################################################################################
# 4. COMPUTE (PUBLIC EC2 INSTANCES)
################################################################################

variable "public_instances" {
  description = "List of public EC2 instance configurations."

  type = list(object({
    name          = string
    ami           = string
    instance_type = string
    key_name      = string
    volume_size   = number
    volume_type   = string
  }))
}

################################################################################
# 5. EKS SETTINGS
################################################################################

variable "eks_cluster_name" {
  description = "EKS Cluster name."
  type        = string
}

variable "eks_cluster_role_name" {
  description = "IAM Role name for EKS Control Plane."
  type        = string
}

variable "node_group_name" {
  description = "EKS Node Group name."
  type        = string
}

variable "eks_node_group_role_name" {
  description = "IAM Role name for EKS Worker Nodes."
  type        = string
}

variable "node_instance_types" {
  description = "Instance types used by EKS nodes."
  type        = list(string)
}

variable "node_instance_capacity_type" {
  description = "Node capacity type (ON_DEMAND or SPOT)."
  type        = string
}

variable "node_disk_size" {
  description = "Root disk size for EKS nodes."
  type        = number
}

variable "node_desired_size" {
  description = "Desired node count."
  type        = number
}

variable "node_max_size" {
  description = "Maximum node count."
  type        = number
}

variable "node_min_size" {
  description = "Minimum node count."
  type        = number
}

################################################################################
# 6. S3 STATE STORAGE
################################################################################

variable "tfstate_backup_s3_bucket_name" {
  description = "S3 bucket name for Terraform state."
  type        = string
}

variable "tfstate_backup_s3_tag_name" {
  description = "Name tag for S3 bucket."
  type        = string
}

variable "tfstate_backup_s3_environment_name" {
  description = "Environment tag (Dev/Prod)."
  type        = string
}
