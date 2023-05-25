#------------------------------------------------------------------------------
# Vend TFC JWT auth method in the namespace for TFC Workspace
#------------------------------------------------------------------------------
resource "vault_jwt_auth_backend" "tfc" {
  for_each = toset(local.namespaces)

  namespace = each.value

  path               = var.tfc_jwt_auth_default_path
  type               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"

  depends_on = [

  ]

}

resource "vault_jwt_auth_backend_role" "this" {
  for_each = local.workspaces

  namespace = each.value.vault_namespace
  backend   = vault_jwt_auth_backend.tfc[each.value.vault_namespace_key].path
  role_name = each.value.vault_role_name

  role_type = "jwt"

  # more elevated permissions
  token_policies = each.value.vault_token_policies

  bound_audiences   = ["vault.workload.identity"]
  bound_claims_type = "glob"

  bound_claims = {
    sub                       = "organization:${each.value.tfc_organization_name}:project:${each.value.tfc_project_name}:workspace:${each.value.tfc_workspace_name}:run_phase:*"
    terraform_organization_id = each.value.tfc_organization_id
    terraform_project_id      = each.value.tfc_project_id
    terraform_workspace_id    = each.value.tfc_workspace_id
  }

  user_claim        = "terraform_full_workspace"
  token_ttl         = each.value.token_ttl
  token_max_ttl     = each.value.token_max_ttl
  token_num_uses    = each.value.token_num_uses
  token_type        = each.value.token_type
  token_bound_cidrs = each.value.token_bound_cidrs

  depends_on = [
    vault_jwt_auth_backend.tfc
  ]
}
