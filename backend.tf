terraform {
  backend "s3" {
    bucket         = "mythravarun-iac-lab-tfstate"
    key            = "/backend_support/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "mythravarun-iac-lab-tfstate-locks"
    encrypt        = true
  }
}