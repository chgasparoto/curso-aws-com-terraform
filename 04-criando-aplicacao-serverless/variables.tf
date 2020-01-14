variable "region" {
  default = "us-east-1"
}

variable "account_id" {
  default = ""
}

variable "env" {
  default = "dev"
}

variable "cg_pool" {
  default = "Todos"
}

variable "cg_client" {
  default = "todos-app-client"
}

variable "cg_domain" {
  default = "todos-api"
}

variable "dbname" {
  default = "todos"
}

variable "read_capacity" {
  default = 5
}

variable "write_capacity" {
  default = 5
}

variable "api_name" {
  default = "todos terraform"
}

variable "api_description" {
  default = "API built with Terraform"
}

variable "sns_topic_name" {
  default = "s3-data-drop"
}

