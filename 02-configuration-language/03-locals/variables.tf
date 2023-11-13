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
  description = "The region to deploy the infra to"
  # default     = "eu-central-1"

  validation {
    condition     = can(regex("^[a-z][a-z]-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "Invalid AWS region name"
  }
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile to use to authenticate with Terraform. Use 'default' in case you have only one account configured"
  default     = "tf_macm1_ggasparoto"
}

variable "tags" {
  type        = map(string)
  description = "The common tags for all resources"
  default = {

  }
}

variable "dynamodb_field_list" {
  type        = list(string)
  description = "List of fields that the DynamoDB table has"
  default     = ["UserId", "GameTitle"]
}

variable "database_config" {
  type = object({
    table_name          = string
    read_capacity       = optional(number, 3)
    write_capacity      = optional(number, 3)
    deletion_protection = optional(bool, false)
    hash_key = object({
      name = string
      type = string
    })
    range_key = object({
      name = string
      type = string
    })
  })
  description = "The configuration to create the DynamoDB table with"
  default = {
    table_name = "GameScores"
    hash_key = {
      name = "UserId"
      type = "S"
    }
    range_key = {
      name = "GameTitle"
      type = "S"
    }
  }
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
  default     = "10.0.0.0/16"
  sensitive   = true
}

variable "service_name" {
  type        = string
  description = ""
  default     = "game_store_service"
}
