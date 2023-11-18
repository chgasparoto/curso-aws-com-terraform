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
    type     = "t4g.nano"
    key_name = "cleber_kp"
  }
}

# variable "autoscaling_group_config" {
#   type = object({
#     max_size = number
#   })
# }
