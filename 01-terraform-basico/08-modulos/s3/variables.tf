variable "name" {}

variable "acl" {
  default = "private"
}

variable "versioning" {
  default = false
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "object_key" {
  default = ""
}

variable "object_source" {
  default = ""
}

variable "create_object" {
  default = false
}
