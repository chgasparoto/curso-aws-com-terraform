terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22"
    }
  }

  backend "s3" {
    bucket         = "tfstate-2023-871055234888"
    key            = "dev/05-outputs/networking/terraform.tfstate"
    region         = "eu-central-1"
    profile        = "tf_macm1_ggasparoto"
    dynamodb_table = "tflock-tfstate-2023-871055234888"
  }
}
