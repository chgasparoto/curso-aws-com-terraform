variable "aws_region" {
  type        = string
  description = ""
  default     = "eu-central-1"
}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "tf014"
}

variable "aws_account_id" {
  type        = number
  description = ""
  default     = 968339500772
}

variable "service_name" {
  type        = string
  description = ""
  default     = "autoscaling-app"
}

variable "ami" {
  default = "ami-0233214e13e500f77"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_pair" {
  default = "cleber"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}
