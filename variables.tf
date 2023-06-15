variable "tfc_shared_roles" {
  default = []
  type = list(object({
    vault_namespace         = optional(string)
    vault_token_policies    = list(string)
    vault_auth_mount        = optional(string)
    tfc_organization_name   = optional(string)
    tfc_project_name        = optional(string)
    tfc_workspace_name      = optional(string)
    tfc_organization_id     = optional(string)
    tfc_project_id          = optional(string)
    tfc_workspace_ids       = optional(list(string))
    claim_project_part      = optional(string)
    claim_organization_part = optional(string)
    claim_workspace_part    = optional(string)
    user_claim              = optional(string)
    vault_role_name         = optional(string)
    vault_role              = optional(string)
    quota                 = optional(map(any))
  }))
  description = "List of shared roles"
}
variable "tfc_workspaces" {
  default = []
  type = list(object({
    vault_namespace       = string
    vault_token_policies  = list(string)
    vault_auth_mount      = optional(string)
    tfc_organization_name = optional(string)
    tfc_project_name      = optional(string)
    tfc_workspace_name    = optional(string)
    tfc_organization_id   = optional(string)
    tfc_project_id        = optional(string)
    tfc_workspace_id      = optional(string)
    claim_workspace_part  = optional(string)
    user_claim            = optional(string)
    vault_role_name       = optional(string)
    vault_role            = optional(string)
    quota                 = optional(map(any))
  }))
  description = "List of Terraform cloud workspaces to be authorized"
}

#
# Auth Mount Settings
#
variable "auth_mount_path" {
  type        = string
  default     = "tfc"
  description = "Vault JWT TFC Authentication path for the namespace"
}

variable "auth_token_issuer" {
  type        = string
  default     = "https://app.terraform.io"
  description = "Vault JWT TFC Authentication path for the namespace"
}

variable "auth_description" {
  type        = string
  default     = "Terraform Managed Auth Mount"
  description = "JWT Auth Backend Description"
}

variable "auth_mount_tune" {
  description = "Authentication mount tune"
  default     = null
  type = object({
    default_lease_ttl            = optional(string)
    max_lease_ttl                = optional(string)
    audit_non_hmac_response_keys = optional(list(string))
    audit_non_hmac_request_keys  = optional(list(string))
    listing_visibility           = optional(string)
    passthrough_request_headers  = optional(list(string))
    allowed_response_headers     = optional(list(string))
    token_type                   = optional(string)
  })
}

variable "vault_namespace" {
  type        = string
  default     = "admin"
  description = "Vault namespace to execute this module"
}

#
# Role Settings
#
variable "role_name_format" {
  description = "Format string to generate Vault role name. The first parameter is the organization, and the second is the workspace name"
  type        = string
  default     = "%[1]s-%[2]s"
}

variable "bound_audiences" {
  default     = ["vault.workload.identity"]
  description = "List of audiences to be allowed for JWT auth roles"
  type        = list(string)
}

variable "default_user_claim" {
  default     = "terraform_full_workspace"
  description = "The claim to use to uniquely identify the user; this will be used as the name for the Identity entity alias created due to a successful login."
  type        = string
}

variable "claim_mappings" {
  description = "Mapping of claims to metadata"
  type        = map(string)
  default = {
    terraform_run_phase         = "terraform_run_phase"
    terraform_apply_phase       = "terraform_apply_phase"
    terraform_workspace_id      = "terraform_workspace_id"
    terraform_workspace_name    = "terraform_workspace_name"
    terraform_organization_id   = "terraform_organization_id"
    terraform_organization_name = "terraform_organization_name"
    terraform_project_id        = "terraform_project_id"
    terraform_project_name      = "terraform_project_name"
    terraform_run_id            = "terraform_run_id"
    terraform_full_workspace    = "terraform_full_workspace"
  }
}

# default values

variable "default_vault_address" {
  default     = "http://localhost:8200"
  description = "Default Vault address"
}

variable "default_vault_token" {
  default     = "root"
  description = "Default Vault token"
}
variable "default_token_display_name" {
  default     = "tfc-auth-vending-admin"
  description = "Vault Token display name"
}

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

variable "identity_name_format" {
  description = "Identity name format string. Will look like tfc-organization-workspace_name"
  type        = string
  default     = "tfc-%[1]s-%[2]s-%[3]s"
}

variable "default_max_leases" {
  default = "100"
  type = number
  description = "The maximum number of leases to be allowed by the quota rule. The max_leases must be positive."
}

variable "default_rate_limit_rate" {
  default = "10"
  type = number
  description = "The maximum number of requests at any given second to be allowed by the quota rule. The rate must be positive."
}

variable "default_rate_limit_interval" {
  default = "1"
  type = number
  description = "The duration in seconds to enforce rate limiting for"
}

variable "default_rate_limit_block_interval" {
  default = "10"
  type = number
  description = "If set, when a client reaches a rate limit threshold, the client will be prohibited from any further requests until after the 'block_interval' in seconds has elapsed."
}
