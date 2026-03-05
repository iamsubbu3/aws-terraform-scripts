################################################################################
# 1. CORE NETWORKING OUTPUTS
################################################################################

output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.main.id
}

################################################################################
# 2. SUBNET IDENTIFIERS
################################################################################

output "public_subnet_ids" {
  description = "IDs of all public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of all private subnets."
  value       = aws_subnet.private[*].id
}

################################################################################
# 3. OPTIONAL DEBUG OUTPUTS
################################################################################

output "public_subnet_azs" {
  description = "Availability Zones of public subnets."
  value       = aws_subnet.public[*].availability_zone
}

output "private_subnet_azs" {
  description = "Availability Zones of private subnets."
  value       = aws_subnet.private[*].availability_zone
}
