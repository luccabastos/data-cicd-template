variable "dev_account_id" {
    description = "Development Account ID"
    type = number
    validation {
        condition     = length(var.dev_account_id) == 12
        error_message = "Dev account ID must be 12 characters long."
    }
}

variable "stg_account_id" {
    description = "Staging Account ID"
    type = number
    validation {
        condition     = length(var.dev_account_id) == 12
        error_message = "Dev account ID must be 12 characters long."
    }
}

variable "prd_account_id" {
    description = "Production Account ID"
    type = number
    validation {
        condition     = length(var.dev_account_id) == 12
        error_message = "Dev account ID must be 12 characters long."
    }
}

variable "dockerhub_secret_arn" {
    description = "Dockerhub Secret Arn, is a Secrets Manager Secret that will be granted access to CodeBuild"
    type = string
}

variable "customer" {
  type = string
  description = "Customer name, used to identify resources"
}
