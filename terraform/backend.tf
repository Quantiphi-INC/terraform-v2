# Define Terraform backend using a S3 bucket for storing the Terraform state
terraform {
  backend "s3" {
    bucket = "terraform-statefiles-bucket-163450518166"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}