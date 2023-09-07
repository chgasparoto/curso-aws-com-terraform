variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "eu-central-1"
}

variable "instance_type" {
  type        = string
  description = "Instance computing power"
  default     = "t3.micro"
}
