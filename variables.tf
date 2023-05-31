variable "tfc_shared_roles" {
  type = list(object({
    vault_namespace = optional(string)
    vault_token_policies = list(string)
    vault_auth_mount = optional(string)
    tfc_organization_name = optional(string)
    tfc_project_name = optional(string)
    tfc_workspace_name = optional(string)
    tfc_organization_id = optional(string)
    tfc_project_id = optional(string)
    tfc_workspace_ids = optional(list(string))
    claim_project_part = optional(string)
    claim_organization_part = optional(string)
    claim_workspace_part = optional(string)
    user_claim = optional(string)
    vault_role_name = optional(string)
    vault_role = optional(string)
  }))
  description = "List of shared roles"
}
variable "tfc_workspaces" {
  type = list(object({
    vault_namespace = string
    vault_token_policies = list(string)
    vault_auth_mount = optional(string)
    tfc_organization_name = optional(string)
    tfc_project_name = optional(string)
    tfc_workspace_name = optional(string)
    tfc_organization_id = optional(string)
    tfc_project_id = optional(string)
    tfc_workspace_id = optional(string)
    claim_workspace_part = optional(string)
    user_claim = optional(string)
    vault_role_name = optional(string)
    vault_role = optional(string)
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
    audit_non_hmac_response_keys = optional(string)
    audit_non_hmac_request_keys  = optional(string)
    listing_visibility           = optional(string)
    passthrough_request_headers  = optional(string)
    allowed_response_headers     = optional(string)
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
