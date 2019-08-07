variable "region" {
  default = "eu-central-1"
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

variable "az_count" {
  default = 2
}

variable "ecs_task_execution_role_name" {
  default = "EcsTaskExecutionRole"
}

variable "fargate_cpu" {
  default = 512
}

variable "fargate_memory" {
  default = 1024
}

variable "app_port" {
  default = 3000
}

variable "app_count" {
  default = 2
}

variable "health_check_path" {
  default = "/"
}

variable "ecs_auto_scale_role_name" {
  default = "EcsAutoScaleRole"
}

variable "ac_min_capacity" {
  default = 2
}

variable "ac_max_capacity" {
  default = 5
}

variable "cidrblock" {
  default = "10.1.0.0/16"
}

variable "log_retention" {
  default = 5
}