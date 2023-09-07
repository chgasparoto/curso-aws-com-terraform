variable "name" {
  description = "Bucket unique name. It can contain only numbers, letters and dashes"
  type        = string
}

variable "ownership" {
  description = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  type        = string
  default     = "BucketOwnerPreferred"
}

variable "acl" {
  description = "Access Control Lists. It defines which AWS accounts or groups are granted access and the type of access"
  type        = string
  default     = "private"
}

variable "policy" {
  description = "Bucket policy"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Whether or not to force destroy the bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Bucket tags"
  type        = map(string)
  default     = {}
}

variable "key_prefix" {
  description = "Prefix to put your key(s) inside the bucket. E.g.: logs -> all files will be uploaded under logs/"
  type        = string
  default     = ""
}

variable "filepath" {
  description = "The local path where the desired files will be uploaded to the bucket"
  type        = string
  default     = ""
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type = object({
    expected_bucket_owner = optional(string)
    status                = optional(string)
    mfa                   = optional(string)
    mfa_delete            = optional(string)
  })

  default = {}

  validation {
    condition     = var.versioning.status != null ? contains(["Enabled", "Suspended", "Disabled"], var.versioning.status) : true
    error_message = "Allowed values for versioning.status are \"Enabled\", \"Suspended\", \"Disabled\"."
  }
}

variable "website" {
  description = "Map containing website configuration."
  type        = map(string)
  default     = {}
}

variable "logging" {
  description = "Map containing logging configuration."
  type        = map(string)
  default     = {}
}
