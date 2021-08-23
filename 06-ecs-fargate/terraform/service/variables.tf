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

variable "az_count" {
  type        = number
  description = ""
  default     = 2
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = ""
  default     = "EcsTaskExecutionRole"
}

variable "fargate_cpu" {
  type        = number
  description = ""
  default     = 512
}

variable "fargate_memory" {
  type        = number
  description = ""
  default     = 1024
}

variable "app_port" {
  type        = number
  description = ""
  default     = 80
}

variable "app_count" {
  type        = number
  description = ""
  default     = 2
}

variable "app_image" {
  type        = string
  description = ""
  default     = ""
}

variable "health_check_path" {
  type        = string
  description = ""
  default     = "/healthcheck"
}

variable "ecs_auto_scale_role_name" {
  type        = string
  description = ""
  default     = "EcsAutoScaleRole"
}

variable "as_min_capacity" {
  type        = number
  description = ""
  default     = 2
}

variable "as_max_capacity" {
  type        = number
  description = ""
  default     = 5
}

variable "cidrblock" {
  type        = string
  description = ""
  default     = "10.1.0.0/16"
}

variable "log_retention" {
  type        = number
  description = ""
  default     = 5
}
