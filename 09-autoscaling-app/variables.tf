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

variable "service_name" {
  type        = string
  description = "The service name identifier"
  default     = "autoscaling-app"
}

variable "instance_type" {
  type        = string
  description = "Instance computing power"
  default     = "t3.micro"
}

variable "instance_key_name" {
  type        = string
  description = "The pem key name to access the instace through the terminal"
  default     = "cleber_kp"
}
