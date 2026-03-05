################################################################################
# PUBLIC EC2 INSTANCES (FOR_EACH BASED)
################################################################################

locals {
  instances_map = {
    for idx, inst in var.public_instances :
    inst.name => merge(inst, {
      subnet_index = idx
    })
  }
}

resource "aws_instance" "public" {

  for_each = local.instances_map

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  # IAM role attached ONLY to terraform-public-instance-3
  iam_instance_profile = each.key == "terraform-public-instance-3" ? aws_iam_instance_profile.ec2_profile.name : null

  subnet_id = element(
    var.public_subnet_ids,
    each.value.subnet_index % length(var.public_subnet_ids)
  )

  associate_public_ip_address = true

  root_block_device {
    volume_size = each.value.volume_size
    volume_type = each.value.volume_type
  }

  tags = {
    Name        = each.value.name
    Environment = "Dev"
  }

  depends_on = [
    aws_iam_instance_profile.ec2_profile
  ]
}
