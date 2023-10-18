provider "aws" {
  region  = "eu-central-1"
  profile = "tf_mac_air_m1_ggasparoto"
}

resource "aws_s3_bucket" "fotos" {
  bucket = "meu-bucket-criado-com-terraform-2023-01"

  tags = {
    CriadoEm  = "30/09/2023"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "fotos" {
  bucket = aws_s3_bucket.fotos.id

  versioning_configuration {
    status = "Enabled"
  }
}
