terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.15"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }

  backend "s3" {
    bucket         = "tfstate-2023-871055234888"
    key            = "dev/05-modules/01-consuming-modules/terraform.tfstate"
    region         = "eu-central-1"
    profile        = "tf_macm1_ggasparoto"
    dynamodb_table = "tflock-tfstate-2023-871055234888"
  }
}
