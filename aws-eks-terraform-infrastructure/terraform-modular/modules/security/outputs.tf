################################################################################
# SECURITY GROUP OUTPUTS
################################################################################

output "sg_id" {
  description = "The ID of the security group."
  value       = aws_security_group.sg.id
}

output "sg_arn" {
  description = "ARN of the security group."
  value       = aws_security_group.sg.arn
}

output "sg_name" {
  description = "Name of the security group."
  value       = aws_security_group.sg.name
}
