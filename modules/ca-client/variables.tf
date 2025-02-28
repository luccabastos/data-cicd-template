variable "devops_account_id" {
  description = "DevOps Account Number"
  type = string
  validation {
    condition     = length(var.devops_account_id) == 12
    error_message = "DevOps Account ID must be 12 digits"
  }
}

variable "artifact_bucket_name" {
  description = "Artifacts bucket name"
  type = string
}

variable "artifact_bucket_kms_key_arn" {
    description = "Artifacts KMS Key Arn"
    type = string
}

variable "customer" {
  type = string
}