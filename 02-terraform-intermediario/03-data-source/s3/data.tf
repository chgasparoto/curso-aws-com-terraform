data "terraform_remote_state" "instance" {
  backend = "s3"

  config = {
    bucket  = "tfstate-968339500772"
    key     = "dev/03-data-sources-ec2/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}
