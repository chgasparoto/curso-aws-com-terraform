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
