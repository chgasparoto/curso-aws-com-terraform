variable "environment" {
  type        = string
  description = "The environment to deploy to"
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "eu-central-1"
}

variable "aws_profile" {
  type        = string
  description = "The profile to use to get access for Terraform"
  default     = "custom_profile"
}
