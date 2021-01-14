# https://www.terraform.io/docs/configuration/variables.html
# Precedence: https://www.terraform.io/docs/configuration/variables.html#variable-definition-precedence
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

# ami-035be7bafff33b6b6
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "type" {
  type        = string
  description = ""
}

variable "ips" {
  type        = list(string)
  description = ""
  default     = ["3ffe:1900:4545:3:200:f8ff:fe21:67cf", "3ffe:1900:4545:3:200:f8ff:fe21:67cd"]
}

variable "tags" {
  type        = map(string)
  description = ""

  default = {
    "Name" = "Nodejs"
    "Env"  = "Dev"
  }
}

