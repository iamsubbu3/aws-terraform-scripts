################################################################################
# 1. GLOBAL SETTINGS
################################################################################
aws_region = "us-east-1"

################################################################################
# 2. VPC & NETWORKING
################################################################################
vpc_cidr_block   = "10.0.0.0/16"
instance_tenancy = "default"
vpc_name         = "terraform-vpc"

# --- Public Subnets ---
public_subnet_1_cidr_block = "10.0.1.0/24"
public_subnet_1_name       = "terraform-public-subnet-1"
map_public_ip_on_launch_1  = true
public_subnet_1_avail_zone = "us-east-1a"

public_subnet_2_cidr_block = "10.0.2.0/24"
public_subnet_2_name       = "terraform-public-subnet-2"
map_public_ip_on_launch_2  = true
public_subnet_2_avail_zone = "us-east-1b"

public_subnet_3_cidr_block = "10.0.3.0/24"
public_subnet_3_name       = "terraform-public-subnet-3"
map_public_ip_on_launch_3  = true
public_subnet_3_avail_zone = "us-east-1c"

# --- Private Subnets ---
private_subnet_1_cidr_block = "10.0.4.0/24"
private_subnet_1_name       = "terraform-private-subnet-1"
private_subnet_1_avail_zone = "us-east-1a"

private_subnet_2_cidr_block = "10.0.5.0/24"
private_subnet_2_name       = "terraform-private-subnet-2"
private_subnet_2_avail_zone = "us-east-1b"

private_subnet_3_cidr_block = "10.0.6.0/24"
private_subnet_3_name       = "terraform-private-subnet-3"
private_subnet_3_avail_zone = "us-east-1c"

# --- Gateway & Routing ---
igw_name             = "terraform-igw"
eip_name             = "terraform-eip"
nat_gw_name          = "terraform-NAT-gw"
public_rt_cidr_block = "0.0.0.0/0"
public_rt_name       = "terraform-public-rt"
private_rt_cidr_block = "0.0.0.0/0"
private_rt_name      = "terraform-private-rt"

################################################################################
# 3. SECURITY GROUPS
################################################################################
sg_name         = "terraform-sg"
my_ip           = "49.206.132.27/32"
eks_jump_server = "0.0.0.0/0"

################################################################################
# 4. EC2 PUBLIC INSTANCES (Jenkins/Ansible)
################################################################################
# Instance 1
public_instance_ami_1              = "ami-0ecb62995f68bb549"
public_instance_type_1             = "t3.large"
public_instance_key_pair_1         = "iamsubbu-keypair"
public_instance_associate_ip_add_1 = true
public_instance_volume_size_1      = 50
public_instance_volume_type_1      = "gp3"
public_instance_name_1             = "Ansible-server"

# Instance 2
public_instance_ami_2              = "ami-0ecb62995f68bb549"
public_instance_type_2             = "t3.large"
public_instance_key_pair_2         = "iamsubbu-keypair"
public_instance_associate_ip_add_2 = true
public_instance_volume_size_2      = 50
public_instance_volume_type_2      = "gp3"
public_instance_name_2             = "Jenkins-server"

# Instance 3
public_instance_ami_3              = "ami-0ecb62995f68bb549"
public_instance_type_3             = "t3.large"
public_instance_key_pair_3         = "iamsubbu-keypair"
public_instance_associate_ip_add_3 = true
public_instance_volume_size_3      = 50
public_instance_volume_type_3      = "gp3"
public_instance_name_3             = "K8s-server"

################################################################################
# 5. EKS CLUSTER SETTINGS
################################################################################
eks-cluster_name      = "subbu-cluster"
eks-cluster_role_name = "eks-cluster-role"

# --- Worker Node Group ---
eks-node-group-role-name                    = "eks-node-group-role"
node_group_name                             = "SPOT-node-group"
node_instance_capacity_type                 = "SPOT"
node_instance_capacity_type_label_name      = "SPOT"
node_instance_capacity_lifecycle_label_name = "SPOT"
node_instance_type                          = "t3.large"
node_desired_size                           = 2
node_max_size                               = 3
node_min_size                               = 1
node_disk_size                              = 50

################################################################################
# 6. S3 BACKEND / STATE STORAGE
################################################################################
tfstate_backup_s3_bucket_name      = "terraform-subbu-tf-test-bucket"
tfstate_backup_s3_tag_name         = "terraform-subbu-tf-test-bucket"
tfstate_backup_s3_environment_name = "Dev"