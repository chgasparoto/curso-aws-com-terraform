variable "environment" {
  type        = string
  description = "The environment to deploy to"
}

variable "aws_region" {
  type        = string
  description = "The region to deploy to"
}

variable "aws_profile" {
  type        = string
  description = "The profile to use to get access for Terraform"
}

variable "instance_ami" {
  type        = string
  description = "The AMI the instance will use. E.g.: Ubuntu, Windows, etc"
}

variable "instance_type" {
  type        = string
  description = "Instance computing power"
}

variable "instance_tags" {
  type        = map(string)
  description = "The tags to identify the instances created by Terraform"
  default = {
    Name    = "Ubuntu"
    Project = "Curso AWS com Terraform"
  }
}
