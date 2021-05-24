variable "aws_region" {
  type        = string
  description = ""
  default     = "eu-central-1"
}

variable "aws_account_id" {
  type        = number
  description = ""
  default     = 968339500772
}

variable "env" {
  default = "dev"
}

variable "app_name" {
  default = "nodejs-app"
}

variable "app_folder" {
  default = "../app"
}
