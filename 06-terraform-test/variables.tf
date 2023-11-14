variable "aws_region" {
  description = "The region to deploy the infra to"
  default     = "eu-central-1" # Frankfurt
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z]-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "Invalid AWS region name"
  }
}

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  default     = null
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Invalid S3 bucket name"
  }
}

variable "table_name" {
  description = "Name of the DynamoDB table. Must be unique."
  default     = null
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{3,63}$", var.table_name))
    error_message = "Invalid DynamoDB table name. It should only contain alphanumeric characters, dots (.), dashes (-), and underscores (_)."
  }
}

variable "read_capacity" {
  description = "DynamoDB read capacity"
  default     = 3
  type        = number

  validation {
    condition     = min(var.read_capacity) > 0
    error_message = "Invalid number. Please provide a valid numeric value greater than zero."
  }
}

variable "write_capacity" {
  description = "DynamoDB read capacity"
  default     = 3
  type        = number

  validation {
    condition     = min(var.write_capacity) > 0
    error_message = "Invalid number. Please provide a valid numeric value greater than zero."
  }
}
