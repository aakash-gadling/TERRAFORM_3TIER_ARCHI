# Store the terraform state file in S3
terraform {
  backend "s3" {
    bucket  = "akku573-terraform-state"
    key     = "jupiter-website-ecs.tfstate"
    region  = "ap-south-1"
 }
}
