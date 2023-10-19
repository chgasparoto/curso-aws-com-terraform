variable "environment" {
  type        = string
  description = "The environment to deploy the infra to"
  default     = "dev"

  validation {
    condition     = var.environment == "dev" || var.environment == "prod"
    error_message = "We only have two environments (dev and prod)"
  }
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the infrastructure to"
  default     = "eu-central-1"

  validation {
    condition     = substr(var.aws_region, 0, 2) == "eu"
    error_message = "Only European regions can be selected"
  }
}

variable "aws_profile" {
  type        = string
  description = "The credentials Terraform should use to authenticate into AWS"
  default     = "tf_mac_air_m1_ggasparoto"
}

variable "allowed_fields" {
  type        = list(string)
  description = "Table fields available to use"
  default     = ["UserId", "GameTitle", "TopScore"]
}

variable "db_config" {
  type = object({
    table_name          = string
    read_capacity       = optional(number, 3)
    write_capacity      = optional(number, 3)
    deletion_protection = optional(bool, false)
  })
  description = "Configuration for the dynamodb database"
  default = {
    table_name = "GameScores"
  }
}

variable "tags" {
  type        = map(string)
  description = "The common tags for all resources"
  default = {
    "Project"    = "Curso AWS com Terraform"
    "Module"     = "Configuration Language"
    "Component"  = "Variables"
    "CreateAt"   = "2023-10-01"
    "ManagedBy"  = "Terraform"
    "Owner"      = "Cleber Gasparoto"
    "Repository" = "github.com/chgasparoto/curso-aws-com-terraform"
  }
}
