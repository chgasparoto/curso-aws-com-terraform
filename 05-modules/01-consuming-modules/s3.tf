module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.15.1"

  bucket = random_pet.service_name.id
}

module "s3_local" {
  source = "../02-creating-modules"
}
