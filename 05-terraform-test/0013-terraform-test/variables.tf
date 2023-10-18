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
