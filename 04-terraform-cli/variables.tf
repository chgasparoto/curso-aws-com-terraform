variable "environment" {
  type        = string
  description = "The environment to deploy the infra to"

  # validation {
  #   condition     = var.environment == "dev" || var.environment == "prod"
  #   error_message = "We only have two environments (dev and prod)"
  # }
}

variable "aws_region" {
  type        = string
  description = "The region to deploy the infra to"

  validation {
    condition     = can(regex("^[a-z][a-z]-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "Invalid AWS region name"
  }
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance power"
  default     = "t3.micro"
}
