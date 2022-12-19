terraform {
  backend "s3" {
    bucket = "my-tf-s3-backend"
    key    = "prod/terraform.tfstate"
    region = "ap-south-1"
  }
}