variable "tfc_jwt_auth_default_path" {
  type        = string
  default     = "tfc"
  description = "Vault JWT TFC Authentication path for the namespace"
}

variable "tfc_workspaces" {
  default = []
  type = list(object({
    tfc_organization_id   = string
    tfc_organization_name = string
    tfc_project_id        = string
    tfc_project_name      = string
    tfc_workspace_id      = string
    tfc_workspace_name    = string
    token_policies        = optional(list(string))
    # vault_namespace_path  = optional(string, null)
    vault_role_name = optional(string, null)
    vault_namespace = string
    additional_data = any
  }))
  description = "Input for this module. List of workspaces"
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "Vault namespace to execute this module"
}

# default values

variable "default_token_ttl" {
  default     = 60
  description = "Default token_ttl"
}

variable "default_token_max_ttl" {
  default     = 3600
  description = "Default token_max_ttl"
}

variable "default_token_num_uses" {
  default     = 0
  description = "Default token_num_uses"
}

variable "default_token_type" {
  default     = "service"
  description = "Default token_type"
}

variable "default_token_bound_cidrs" {
  default     = []
  description = "Default token_bound_cidrs"
}
