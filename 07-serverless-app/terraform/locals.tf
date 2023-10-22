locals {
  account_id              = data.aws_caller_identity.this.account_id
  namespaced_service_name = "${var.service_name}-${var.environment}"

  lambdas_path = "lambdas"
  code_path    = "${path.module}/../src"
  code_hash    = sha1(join("", [for f in fileset("${local.code_path}", "**") : filesha1("${local.code_path}/${f}")]))

  has_domain_name                      = var.domain_name != null
  create_resource_based_on_domain_name = local.has_domain_name ? 1 : 0

  formatted_cors = {
    headers = "'${join(",", var.cors_allow_headers)}'"
    methods = "'${join(",", var.cors_allow_methods)}'"
    # origins     = var.cors_allow_credentials == "true" ? "'${var.cors_allow_origins_mapping[var.environment]}'" : "'${join(",", var.cors_allow_origins)}'"
    origins     = var.cors_allow_credentials == "true" ? "'${var.cors_allow_origins_mapping["prod"]}'" : "'${join(",", var.cors_allow_origins)}'"
    credentials = "'${var.cors_allow_credentials}'"
  }

  dynamodb_config = {
    partition_key = "TodoId"
    sort_key      = "UserId"
    gsi_name      = "TodosByUser"
    gsi_range_key = "Done"
  }

  common_tags = {
    "Project"    = "Curso AWS com Terraform"
    "Module"     = "Serverless App"
    "CreateAt"   = "2023-10-01"
    "ManagedBy"  = "Terraform"
    "Owner"      = "Cleber Gasparoto"
    "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
  }
}
