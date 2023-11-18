variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "eu-central-1"
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

variable "domain_name" {
  type        = string
  description = "The APEX domain name to deploy the API to"
  default     = null

  validation {
    condition     = var.domain_name != null ? can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9].[a-zA-Z]{2,}$", var.domain_name)) : true
    error_message = "Invalid domain name. It must be a valid domain name."
  }
}

variable "service_domain" {
  type        = string
  description = "The service domain"
  default     = "api-todos"
}

variable "cors_allow_headers" {
  description = "List of allowed headers for CORS requests"
  type        = list(string)
  default = [
    "Content-Type",
    "X-Amz-Date",
    "Authorization",
    "X-Api-Key",
    "X-Amz-Security-Token"
  ]
}

variable "cors_allow_methods" {
  description = "List of allowed methods for CORS requests"
  type        = list(string)
  default = [
    "DELETE",
    "GET",
    "HEAD",
    "OPTIONS",
    "PATCH",
    "POST",
    "PUT",
  ]
}

variable "cors_allow_origins" {
  description = "Allowed origin(s) for CORS requests"
  type        = string
  default     = "*"
}

variable "cors_allow_credentials" {
  description = "Whether to set the credentials or not"
  type        = string
  default     = "false"

  validation {
    condition     = contains(["true", "false"], var.cors_allow_credentials)
    error_message = "CORs allow credentials only accept 'true' or 'false'"
  }
}

variable "create_logs_for_apigw" {
  type        = bool
  description = "Whether to create and send logs from API GW to Cloudwatch"
  default     = false
}
