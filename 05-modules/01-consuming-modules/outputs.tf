# output "logs_bucket_arn" {
#   value = module.s3_logs.arn
# }

output "reports_bucket" {
  value = {
    arn                  = module.s3_reports.arn
    name                 = module.s3_reports.name
    regional_domain_name = module.s3_reports.regional_domain_name
    website_endpoint     = module.s3_reports.website
  }
}

# output "pictures_bucket_name" {
#   value = module.s3_pictures.s3_bucket_id
# }

# output "pictures_bucket_arn" {
#   value = module.s3_pictures.s3_bucket_arn
# }
