
resource "vault_identity_entity" "this" {
  for_each = local.workspaces

  name      = each.value.tfc_workspace_name
  namespace = each.value.vault_namespace

  policies = ["tfc-workspace-policy"]

  metadata = {
    description = "Managed by Terraform"
    provided_by = "TFC Auth Vending Module"
  }
}
resource "vault_identity_entity_alias" "this" {
  for_each = local.workspaces

  name      = each.value.tfc_workspace_entity_alias
  namespace = each.value.vault_namespace

  mount_accessor = vault_jwt_auth_backend.tfc[each.value.vault_namespace_key].accessor
  canonical_id   = vault_identity_entity.this[each.key].id
}
