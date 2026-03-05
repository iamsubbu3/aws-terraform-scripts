################################################################################
# 1. INFRASTRUCTURE CONTEXT
################################################################################

variable "vpc_id" {
  description = "ID of the VPC where this security group will be created."
  type        = string
}

variable "sg_name" {
  description = "Name of the security group."
  type        = string
}

################################################################################
# 2. ACCESS CONTROL SETTINGS
################################################################################

variable "my_ip" {
  description = "Admin IP in CIDR format for SSH access."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.my_ip))
    error_message = "my_ip must be a valid CIDR block (example: 49.xxx.xxx.xxx/32)."
  }
}

variable "eks_jump_server" {
  description = "CIDR block allowed to access EKS API endpoint."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.eks_jump_server))
    error_message = "eks_jump_server must be a valid CIDR block."
  }
}
