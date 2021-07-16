variable "aws_region" {
  type        = string
  description = ""
  default     = "eu-central-1"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "default"
}

variable "aws_account_id" {
  type        = number
  description = ""
  default     = 968339500772
}

variable "env" {
  type        = string
  description = ""
  default     = "dev"
}

variable "app_name" {
  type        = string
  description = ""
  default     = "nodejs-app"
}

variable "app_folder" {
  type        = string
  description = ""
  default     = "../../app"
}
