# Store the terraform state file in S3
terraform {
  backend "s3" {
    bucket  = "akki573-terraform-state"
    key     = "jupiter-website-ecs.tfstate"
    region  = "us-east-1"
    profile = "terraform-user"
  }
}