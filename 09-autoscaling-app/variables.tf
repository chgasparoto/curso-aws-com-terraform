variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "eu-central-1"
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"
  default     = "dev"
}

variable "service_name" {
  type        = string
  description = "The service name identifier"
  default     = "autoscaling-app"
}

variable "instance_config" {
  description = "Instance configuration"
  type = object({
    ami      = string
    type     = string
    key_name = optional(string, null)
  })
  default = {
    ami      = "ami-0479653c00e0a5e59"
    type     = "t4g.micro"
    key_name = "cleber_kp"
  }
}

variable "alb_healthcheck_config" {
  description = "Application Load Balancer configuration for healthchecks"
  nullable    = true
  default     = {}

  type = object({
    enabled             = optional(bool, true)
    healthy_threshold   = optional(number, 5)
    interval            = optional(number, 30)
    matcher             = optional(string, "200")
    path                = optional(string, "/")
    port                = optional(string, "80")
    protocol            = optional(string, "HTTP")
    timeout             = optional(number, 5)
    unhealthy_threshold = optional(number, 5)
  })
}

variable "autoscaling_group_config" {
  description = "Autoscaling group configuration"
  nullable    = true
  default     = {}

  type = object({
    desired_capacity          = optional(number, 1)
    min_size                  = optional(number, 1)
    max_size                  = optional(number, 6)
    health_check_grace_period = optional(number, 300) # 5 minutes
    health_check_type         = optional(string, "ELB")
    force_delete              = optional(bool, true)
  })
}

variable "autoscaling_policy_cpu" {
  description = "Autoscaling policy for CPU Utilization configuration"
  nullable    = true
  default     = {}

  type = object({
    enabled          = optional(bool, true)
    name             = optional(string, "CPU Utilization")
    disable_scale_in = optional(bool, false)
    target_value     = optional(number, 40)
  })
}

variable "autoscaling_policy_alb" {
  description = "Autoscaling policy for ALB request count configuration"
  nullable    = true
  default     = {}

  type = object({
    enabled          = optional(bool, true)
    name             = optional(string, "Load balancer request count")
    disable_scale_in = optional(bool, false)
    target_value     = optional(number, 30)
  })
}
