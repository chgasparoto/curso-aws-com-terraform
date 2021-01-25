data "terraform_remote_state" "server" {
  backend = "s3"

  config = {
    bucket  = "tfstate-968339500772"
    key     = "dev/03-data-sources-s3/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}
