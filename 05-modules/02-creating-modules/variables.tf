variable "name" {
  description = "Bucket unique name. It can contain only numbers, letters and dashes"
  type        = string
  default     = null
}

variable "ownership" {
  description = "Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  type        = string
  default     = "BucketOwnerPreferred"

  validation {
    condition     = contains(["BucketOwnerPreferred", "ObjectWriter", "BucketOwnerEnforced"], var.ownership)
    error_message = "Invalid S3 bucket ownership. Valid values are: \"BucketOwnerPreferred\", \"ObjectWriter\" or \"BucketOwnerEnforced\""
  }
}

variable "acl" {
  description = "Access Control Lists. It defines which AWS accounts or groups are granted access and the type of access"
  type        = string
  default     = "private"
}

variable "policy" {
  description = "Bucket policy"
  type = object({
    json = string
  })
  default = null
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket"
  type        = bool
  default     = false
}

variable "versioning" {
  description = "Map containing versioning configuration"

  type = object({
    expected_bucket_owner = optional(string)
    status                = optional(string)
    mfa                   = optional(string)
    mfa_delete            = optional(string)
  })

  nullable = true
  default  = {}

  validation {
    condition     = var.versioning.status != null ? contains(["Enabled", "Suspended", "Disabled"], var.versioning.status) : true
    error_message = "Allowed values for versioning.status are \"Enabled\", \"Suspended\", \"Disabled\"."
  }
}

variable "public_access" {
  description = "Public access block configuration"

  type = object({
    block_public_acls       = optional(bool)
    block_public_policy     = optional(bool)
    ignore_public_acls      = optional(bool)
    restrict_public_buckets = optional(bool)
  })

  nullable = true
  default  = {}
}

variable "website" {
  description = "Map containing website configuration"

  type = object({
    index_document           = optional(string)
    error_document           = optional(string)
    redirect_all_requests_to = optional(string)
  })

  nullable = true
  default  = {}
}

variable "logging" {
  description = "Map containing logging configuration"

  type = object({
    target_bucket = optional(string)
    target_prefix = optional(string)
  })

  nullable = true
  default  = {}
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
