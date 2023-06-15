#------------------------------------------------------------------------------
# Vend TFC JWT auth method in the namespace for TFC Workspace
#------------------------------------------------------------------------------
resource "vault_jwt_auth_backend" "this" {
  for_each = local.backends

  namespace = each.value.vault_namespace

  path               = each.value.vault_auth_mount
  type               = "jwt"
  oidc_discovery_url = var.auth_token_issuer
  bound_issuer       = var.auth_token_issuer

  dynamic "tune" {
    for_each = var.auth_mount_tune != null ? [var.auth_mount_tune] : []

    content {
      default_lease_ttl            = tune.value.default_lease_ttl
      max_lease_ttl                = tune.value.max_lease_ttl
      audit_non_hmac_response_keys = tune.value.audit_non_hmac_response_keys
      audit_non_hmac_request_keys  = tune.value.audit_non_hmac_request_keys
      listing_visibility           = tune.value.listing_visibility
      passthrough_request_headers  = tune.value.passthrough_request_headers
      allowed_response_headers     = tune.value.allowed_response_headers
      token_type                   = tune.value.token_type
    }
  }

  depends_on = [

  ]

}

resource "vault_jwt_auth_backend_role" "this" {
  for_each = local.roles

  namespace = each.value.vault_namespace
  backend   = vault_jwt_auth_backend.this[each.value.vault_auth_mount_key].path
  role_name = each.value.vault_role_name

  role_type = "jwt"

  # more elevated permissions
  token_policies = each.value.vault_token_policies

  bound_audiences   = var.bound_audiences
  bound_claims_type = "glob"
  user_claim        = each.value.user_claim

  bound_claims = {
    sub = "organization:${each.value.claim_organization_part}:project:${each.value.claim_project_part}:workspace:${each.value.claim_workspace_part}:run_phase:*"

    terraform_organization_id = try(each.value.tfc_organization_id, null)
    terraform_project_id      = try(each.value.tfc_project_id, null)
    terraform_workspace_id    = try(each.value.tfc_workspace_id, null)
  }

  token_ttl         = try(each.value.token_ttl, var.default_token_ttl)
  token_max_ttl     = try(each.value.token_max_ttl, var.default_token_max_ttl)
  token_num_uses    = try(each.value.token_num_uses, var.default_token_num_uses)
  token_type        = try(each.value.token_type, var.default_token_type)
  token_bound_cidrs = try(each.value.token_bound_cidrs, var.default_token_bound_cidrs)

  depends_on = [
    vault_jwt_auth_backend.this
  ]
}

resource "vault_quota_rate_limit" "role" {
  for_each = {
    for key, item in local.roles : key => item
    if item.enable_quota
  }

  namespace = var.vault_namespace
  name = each.value.quota_path

  path = "auth/${each.value.vault_role_path}"

  rate = each.value.rate
  interval = each.value.interval
  block_interval = each.value.block_interval
}
