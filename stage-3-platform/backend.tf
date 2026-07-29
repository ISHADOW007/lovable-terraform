terraform {

  backend "s3" {

    bucket         = "lovable-terraform-state-457724887427"

    key            = "stage-3-platform/terraform.tfstate"

    region         = "ap-south-1"

    dynamodb_table = "lovable-terraform-lock"

    encrypt        = true

  }

}