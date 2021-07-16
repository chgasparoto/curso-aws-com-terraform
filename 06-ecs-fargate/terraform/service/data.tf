data "terraform_remote_state" "ecr" {
  backend = "s3"

  config = {
    bucket  = "tfstate-968339500772"
    key     = "06-ecr/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}
