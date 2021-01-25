variable "bucket" {}
variable "key" {}
variable "src" {}

variable "content_type" {
  type        = string
  description = ""
  default     = "application/octet-stream"
}
