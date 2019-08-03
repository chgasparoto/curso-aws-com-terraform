variable "aws_region" {}
variable "env" {}

variable "app_name" {
  default = "nodejs-app"
}

variable "app_folder" {
  default = "../app"
}

variable "app_port" {}

variable "app_count" {
  description = "Number of docker containers"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "1 vCPU = 1024 CPU units"
}

variable "fargate_memory" {
  description = "in MB"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role Name"
  default     = "myEcsAutoScaleRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = 2
}