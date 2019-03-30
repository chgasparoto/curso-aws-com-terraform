variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = "map"

  default = {
    "dev"  = "ami-035be7bafff33b6b6"
    "prod" = "ami-0080e4c5bc078760e"
  }
}

variable "type" {
  type = "map"

  default = {
    "dev"  = "t2.micro"
    "prod" = "t2.medium"
  }
}
