# # ################################################################################
# # 1. REMOTE BACKEND CONFIGURATION
# # Stores your state file in S3 to allow for team collaboration and safety.
# ################################################################################

# terraform {
#   backend "s3" {
#     bucket  = "terraform-subbu-tf-test-bucket"
#     key     = "Dev/terraform.tfstate"
#     region  = "us-east-1"
#     encrypt = true
    
#     # Best Practice: Add a DynamoDB table for State Locking
#     # dynamodb_table = "terraform-lock-table"
#   }
# }