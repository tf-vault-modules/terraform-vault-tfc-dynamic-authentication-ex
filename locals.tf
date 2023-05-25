locals {
  namespaces = distinct([
    for item in var.tfc_workspaces : "${item.vault_namespace}"
  ])


  workspaces = {
    for r in distinct([
      for item in var.tfc_workspaces : {
        tfc_organization_id        = item.tfc_organization_id,
        tfc_organization_name      = item.tfc_organization_name,
        tfc_project_id             = item.tfc_project_id
        tfc_project_name           = item.tfc_project_name
        tfc_workspace_id           = item.tfc_workspace_id
        tfc_workspace_name         = item.tfc_workspace_name
        tfc_workspace_entity_alias = "organization:${item.tfc_organization_name}:project:${item.tfc_project_name}:workspace:${item.tfc_workspace_name}"

        vault_token_policies = lookup(item, "token_policies", []),
        vault_namespace      = try(item.tfc_vault_namespace, "${item.vault_namespace}")
        vault_namespace_key  = try(item.tfc_vault_namespace, "${item.vault_namespace}")
        vault_role_name      = try(item.tfc_vault_run_role, "${item.tfc_workspace_name}-${item.tfc_workspace_id}")

        token_ttl         = try(item.token_ttl, var.default_token_ttl)
        token_max_ttl     = try(item.token_max_ttl, var.default_token_max_ttl)
        token_num_uses    = try(item.token_num_uses, var.default_token_num_uses)
        token_type        = try(item.token_type, var.default_token_type)
        token_bound_cidrs = try(item.token_bound_cidrs, var.default_token_bound_cidrs)

        key = try(item.key, "${item.vault_namespace}/${item.tfc_workspace_id}")
      }
    ]) : r.key => r
  }
}
