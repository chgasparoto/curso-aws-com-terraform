variable "permissions" {
  type = list(object({
    sid       = string
    effect    = optional(string, "Allow")
    resources = list(string)
    actions   = list(string)
  }))
  description = "The permissions to set for the given policy document"
}


variable "create_log_perms_for_lambda" {
  type        = bool
  description = "Whether to create the Lambda permissions for Cloudwatch"
  default     = false
}

variable "iam_role_name" {
  type        = string
  description = "The name of the IAM role"

  validation {
    condition     = can(regex("^[a-zA-Z0-9+=,.@_-]{1,64}$", var.iam_role_name))
    error_message = "Invalid IAM role name. It must adhere to the naming rules."
  }
}

variable "iam_policy_name" {
  type        = string
  description = "The name of the IAM policy"

  validation {
    condition     = can(regex("^[a-zA-Z0-9+=,.@_ -]{1,128}$", var.iam_policy_name))
    error_message = "Invalid IAM policy name. It must adhere to the naming rules."
  }
}

variable "assume_role_policy" {
  type        = string
  description = "The assume role policy in JSON format"
}
