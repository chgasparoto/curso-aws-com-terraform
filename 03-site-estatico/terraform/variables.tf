variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "eu-central-1"
}

variable "domain" {
  type        = string
  description = "The website main domain"
  default     = ""
}
