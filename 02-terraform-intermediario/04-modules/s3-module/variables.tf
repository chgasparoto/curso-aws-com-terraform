variable "name" {
  type        = string
  description = "Bucket name"
}

variable "acl" {
  type        = string
  description = ""
  default     = "private"
}

variable "versioning" {
  type        = bool
  description = "Weather to enable or not the bucket versioning"
  default     = false
}

variable "tags" {
  type        = object({})
  description = ""
  default     = {}
}

variable "object_key" {
  type        = string
  description = ""
  default     = ""
}

variable "object_source" {
  type        = string
  description = ""
  default     = ""
}

variable "create_object" {
  type        = bool
  description = ""
  default     = false
}
