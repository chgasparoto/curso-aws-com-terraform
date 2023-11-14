# module "s3_logs" {
#   source = "./modules/s3"

#   bucket_name = "module-${random_pet.this.id}-logs-bucket"
# }

# module "s3_reports" {
#   source = "./modules/s3"

#   bucket_name = "module-${random_pet.this.id}-reports-bucket"
# }

# module "s3_pictures" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "3.15.1"
# }

module "s3_reports" {
  source = "../02-creating-modules"

  name = "module-${random_pet.this.id}-reports-bucket"
}
