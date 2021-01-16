variable "env" {}

variable "aws_region" {
  type = object({
    environment = string
  })

  default = {
    "dev"  = "us-east-1"
    "prod" = "sa-east-1"
  }
}
