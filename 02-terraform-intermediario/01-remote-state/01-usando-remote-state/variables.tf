variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "eu-central-1"
}

variable "instance_ami" {
  type        = string
  description = "The AMI the instance will use. E.g.: Ubuntu, Windows, etc"
  default     = "ami-03c3a7e4263fd998c"
}

variable "instance_type" {
  type        = string
  description = "Instance computing power"
  default     = "t3.micro"
}
