################################################################################
# 1. GLOBAL & PROVIDER SETTINGS
################################################################################

variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
}

################################################################################
# 2. VPC & CORE NETWORKING
################################################################################

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "VPC instance tenancy"
  type        = string
}

variable "vpc_name" {
  description = "Tag name for the VPC"
  type        = string
}

# --- Public Subnets ---

variable "public_subnet_1_cidr_block" {
  type = string
}

variable "public_subnet_1_name" {
  type = string
}

variable "map_public_ip_on_launch_1" {
  type = bool
}

variable "public_subnet_1_avail_zone" {
  type = string
}

variable "public_subnet_2_cidr_block" {
  type = string
}

variable "public_subnet_2_name" {
  type = string
}

variable "map_public_ip_on_launch_2" {
  type = bool
}

variable "public_subnet_2_avail_zone" {
  type = string
}

variable "public_subnet_3_cidr_block" {
  type = string
}

variable "public_subnet_3_name" {
  type = string
}

variable "map_public_ip_on_launch_3" {
  type = bool
}

variable "public_subnet_3_avail_zone" {
  type = string
}

# --- Private Subnets ---

variable "private_subnet_1_cidr_block" {
  type = string
}

variable "private_subnet_1_name" {
  type = string
}

variable "private_subnet_1_avail_zone" {
  type = string
}

variable "private_subnet_2_cidr_block" {
  type = string
}

variable "private_subnet_2_name" {
  type = string
}

variable "private_subnet_2_avail_zone" {
  type = string
}

variable "private_subnet_3_cidr_block" {
  type = string
}

variable "private_subnet_3_name" {
  type = string
}

variable "private_subnet_3_avail_zone" {
  type = string
}

################################################################################
# 3. GATEWAYS & ROUTING
################################################################################

variable "igw_name" {
  type = string
}

variable "eip_name" {
  type = string
}

variable "nat_gw_name" {
  type = string
}

variable "public_rt_cidr_block" {
  type = string
}

variable "public_rt_name" {
  type = string
}

variable "private_rt_cidr_block" {
  type = string
}

variable "private_rt_name" {
  type = string
}

################################################################################
# 4. SECURITY GROUPS
################################################################################

variable "sg_name" {
  type = string
}

variable "my_ip" {
  description = "Local IP for SSH admin access"
  type        = string
}

variable "eks_jump_server" {
  description = "Allowed CIDR for EKS API access"
  type        = string
}

################################################################################
# 5. EC2 INSTANCES (Jenkins/Ansible)
################################################################################

# --- Public Instance 1 ---
variable "public_instance_ami_1" {
  type = string
}

variable "public_instance_type_1" {
  type = string
}

variable "public_instance_key_pair_1" {
  type = string
}

variable "public_instance_associate_ip_add_1" {
  type = bool
}

variable "public_instance_volume_size_1" {
  type = number
}

variable "public_instance_volume_type_1" {
  type = string
}

variable "public_instance_name_1" {
  type = string
}

# --- Public Instance 2 ---
variable "public_instance_ami_2" {
  type = string
}

variable "public_instance_type_2" {
  type = string
}

variable "public_instance_key_pair_2" {
  type = string
}

variable "public_instance_associate_ip_add_2" {
  type = bool
}

variable "public_instance_volume_size_2" {
  type = number
}

variable "public_instance_volume_type_2" {
  type = string
}

variable "public_instance_name_2" {
  type = string
}

# --- Public Instance 3 ---
variable "public_instance_ami_3" {
  type = string
}

variable "public_instance_type_3" {
  type = string
}

variable "public_instance_key_pair_3" {
  type = string
}

variable "public_instance_associate_ip_add_3" {
  type = bool
}

variable "public_instance_volume_size_3" {
  type = number
}

variable "public_instance_volume_type_3" {
  type = string
}

variable "public_instance_name_3" {
  type = string
}

################################################################################
# 6. EKS CLUSTER SETTINGS
################################################################################

variable "eks-cluster_name" {
  type = string
}

variable "eks-cluster_role_name" {
  type = string
}

# --- Managed Node Group ---

variable "eks-node-group-role-name" {
  type = string
}

variable "node_group_name" {
  type = string
}

variable "node_instance_capacity_type" {
  type = string
}

variable "node_instance_capacity_type_label_name" {
  type = string
}

variable "node_instance_capacity_lifecycle_label_name" {
  type = string
}

variable "node_instance_type" {
  type = string
}

variable "node_desired_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "node_min_size" {
  type = number
}

variable "node_disk_size" {
  type = number
}

################################################################################
# 7. S3 BACKEND STORAGE
################################################################################

variable "tfstate_backup_s3_bucket_name" {
  type = string
}

variable "tfstate_backup_s3_tag_name" {
  type = string
}

variable "tfstate_backup_s3_environment_name" {
  type = string
}