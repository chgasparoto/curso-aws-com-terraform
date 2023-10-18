variable "environment" {
  type        = string
  description = "The environment to deploy the infra to"
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "We only have two environments (dev and prod)"
  }
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the infrastructure to"
  default     = "eu-central-1"

  validation {
    condition     = substr(var.aws_region, 0, 2) == "eu"
    error_message = "Only European regions can be selected"
  }
}

variable "aws_profile" {
  type        = string
  description = "The credentials Terraform should use to authenticate into AWS"
  default     = "tf_mac_air_m1_ggasparoto"
}

variable "bucket_name" {
  type        = string
  description = "value"
  default     = null

  #   validation {
  #     condition     = can(regex("^(?=^.{3,63}$)[a-z0-9.-]+$", var.bucket_name))
  #     error_message = "Invalid S3 bucket name. It must adhere to the naming rules."
  #   }
}

variable "table_name" {
  type        = string
  description = "value"
  default     = null
}

variable "ec2_instance_type" {
  type        = string
  description = "value"
  default     = "t3.micro"
}

variable "ec2_ami_id" {
  type        = string
  description = "value"
  default     = null
}
