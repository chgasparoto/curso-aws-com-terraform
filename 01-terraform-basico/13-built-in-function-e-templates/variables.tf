variable "env" {}

variable "region" {
  type = "map"

  default = {
    "dev"  = "us-east-1"
    "prod" = "sa-east-1"
  }
}
