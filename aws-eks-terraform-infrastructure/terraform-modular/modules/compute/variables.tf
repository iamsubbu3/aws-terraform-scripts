################################################################################
# 1. SHARED SECURITY CONFIGURATION
# Security groups attached to EC2 instances
################################################################################

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instances."
  type        = list(string)
}

################################################################################
# 2. PUBLIC SUBNET DISTRIBUTION
# Used to automatically spread instances across AZs
################################################################################

variable "public_subnet_ids" {
  description = "List of public subnet IDs where instances will be deployed."
  type        = list(string)
}

################################################################################
# 3. OPTIONAL IAM INSTANCE PROFILE (ATTACH ROLE TO SELECT INSTANCES)
################################################################################

variable "iam_instance_profile_name" {
  description = "IAM Instance Profile name to attach to specific EC2 instances (optional)."
  type        = string
  default     = null
}

################################################################################
# 4. PUBLIC INSTANCE DEFINITIONS (FOR_EACH BASED)
################################################################################

variable "public_instances" {
  description = "Configuration for multiple public EC2 instances."

  type = list(object({
    name          = string
    ami           = string
    instance_type = string
    key_name      = string
    volume_size   = number
    volume_type   = string
  }))
}
