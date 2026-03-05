################################################################################
# 1. VPC CONFIGURATION
################################################################################

variable "vpc_name" {
  description = "The name of the VPC (used for Name tags)."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "vpc_cidr_block must be valid CIDR (example: 10.0.0.0/16)."
  }
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC."
  type        = string
  default     = "default"
}

################################################################################
# 2. NETWORK TOPOLOGY
################################################################################

variable "azs" {
  description = "List of Availability Zones."
  type        = list(string)

  validation {
    condition     = length(var.azs) >= 2
    error_message = "Provide at least two AZs for high availability."
  }
}

variable "public_subnets" {
  description = "List of public subnet CIDRs."
  type        = list(string)

  validation {
    condition     = length(var.public_subnets) == length(var.azs)
    error_message = "Number of public subnets must match number of AZs."
  }
}

variable "private_subnets" {
  description = "List of private subnet CIDRs."
  type        = list(string)

  validation {
    condition     = length(var.private_subnets) == length(var.azs)
    error_message = "Number of private subnets must match number of AZs."
  }
}
