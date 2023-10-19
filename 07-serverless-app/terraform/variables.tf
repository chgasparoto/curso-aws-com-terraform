variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "eu-central-1"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account id to unique identify resources"
  default     = "871055234888"
}

variable "environment" {
  type        = string
  description = "The enviroment to deploy to"
  default     = "dev"
}

variable "service_name" {
  type        = string
  description = "The service name identifier"
  default     = "curso-terraform"
}

variable "service_domain" {
  type        = string
  description = "The service domain"
  default     = "api-todos"
}
