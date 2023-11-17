variable "name" {
  type        = string
  nullable    = false
  description = "Function name"
}

variable "iam_role_arn" {
  type        = string
  nullable    = false
  description = "The IAM ARN containing all the lambda permissions"
}

variable "handler" {
  type        = string
  nullable    = false
  description = "The path to the exported handler function"
}

variable "s3_config" {
  type = object({
    bucket = string
    key    = string
  })
  description = "The S3 config where the lambda artefact is stored"
  nullable    = false
}

variable "code_hash" {
  type        = string
  nullable    = false
  description = "The hash from the lambdas code"
}

variable "description" {
  type        = string
  description = "Describes in high-level what the function does"
  default     = null
}

variable "runtime" {
  type        = string
  description = "The lambda runtime"
  default     = "nodejs18.x"
}

variable "architectures" {
  type        = list(string)
  description = "The list of architetures the lambda supports"
  default     = ["arm64"]
}

variable "timeout_in_secs" {
  type        = number
  description = "The amount of seconds the lambda can run before timing out"
  default     = 15
}

variable "memory_in_mb" {
  type        = number
  description = "The amount of MB the lambda will have for memory"
  default     = 256
}

variable "env_vars" {
  type        = map(any)
  description = "The environments vars for this lambda"
}

variable "log_retetion_days" {
  type        = number
  description = "How long should Cloudwatch keeps the lambda logs"
  default     = 3
}
