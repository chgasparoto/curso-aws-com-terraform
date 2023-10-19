# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "fotos" {
  bucket = "meu-bucket-criado-com-terraform-2023-01"

  tags = {
    "CreateAt"   = "2023-10-01"
    "Module"     = "Terraform Basic"
    "ManagedBy"  = "Terraform"
    "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
resource "aws_s3_bucket_versioning" "fotos" {
  bucket = aws_s3_bucket.fotos.id

  versioning_configuration {
    status = "Enabled"
  }
}
