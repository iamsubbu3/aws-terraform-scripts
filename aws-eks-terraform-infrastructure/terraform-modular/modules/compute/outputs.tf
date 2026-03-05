################################################################################
# PUBLIC INSTANCE OUTPUTS
################################################################################

output "instance_ids" {
  description = "IDs of all public EC2 instances"
  value       = [for instance in values(aws_instance.public) : instance.id]
}

output "public_ips" {
  description = "Public IP addresses of all EC2 instances"
  value       = [for instance in values(aws_instance.public) : instance.public_ip]
}

output "public_dns" {
  description = "Public DNS names of all EC2 instances"
  value       = [for instance in values(aws_instance.public) : instance.public_dns]
}
