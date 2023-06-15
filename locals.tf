locals {
  namespaces = distinct([
    for item in local.roles : "${item.vault_namespace}"
  ])

  backends = {
    for r in distinct([
      for item in local.roles :
      {
        vault_namespace  = item.vault_namespace
        vault_auth_mount = item.vault_auth_mount
        key              = "${item.vault_namespace}/${item.vault_auth_mount}"

        # quotas
        enable_quota = try(item.quota, null) != null ? true : false
        quota_path = "${coalesce(var.auth_mount_path, "tfc")}-${item.vault_role_name}"

        max_leases = try(item.quota.max_leases, var.default_max_leases)
        rate = try(item.quota.default_rate_limit_rate, var.default_rate_limit_rate)
        interval = try(item.quota.default_rate_limit_interval, var.default_rate_limit_interval)
        block_interval = try(item.quota.default_rate_limit_block_interval, var.default_rate_limit_block_interval)
      }
    ]) : r.key => r
  }

  shared_roles = {
    for r in distinct([
      for item in var.tfc_shared_roles : {
        vault_namespace      = item.vault_namespace
        vault_token_policies = item.vault_token_policies
        vault_auth_mount     = item.vault_auth_mount
        vault_role_name      = item.vault_role_name
        vault_namespace_key  = item.vault_namespace
        vault_auth_mount_key = "${item.vault_namespace}/${item.vault_auth_mount}"
        vault_role_path = "${coalesce(item.vault_auth_mount, "tfc")}/${item.vault_role_name}"

        user_claim              = coalesce(item.user_claim, var.default_user_claim)
        claim_organization_part = item.claim_organization_part
        claim_project_part      = item.claim_project_part
        claim_workspace_part    = item.claim_workspace_part

        tfc_organization_id   = item.tfc_organization_id,
        tfc_organization_name = item.tfc_organization_name,
        tfc_project_id        = try(join(", ", item.tfc_project_id), null)
        tfc_project_name      = item.tfc_project_name

        tfc_workspace_id   = try(join(", ", item.tfc_workspace_ids), null)
        tfc_workspace_name = item.tfc_workspace_name

        # quotas
        enable_quota = try(item.quota, null) != null ? true : false
        quota_path = "${coalesce(var.auth_mount_path, "tfc")}-${item.vault_role_name}"

        max_leases = try(item.quota.max_leases, var.default_max_leases)
        rate = try(item.quota.default_rate_limit_rate, var.default_rate_limit_rate)
        interval = try(item.quota.default_rate_limit_interval, var.default_rate_limit_interval)
        block_interval = try(item.quota.default_rate_limit_block_interval, var.default_rate_limit_block_interval)
        
        key = "${item.vault_namespace}/${item.vault_auth_mount}/${item.vault_role_name}"
    }]) : r.key => r
  }

  workspaced_roles = ({
    for item in var.tfc_workspaces : "${coalesce(item.vault_namespace, "root")}/${coalesce(item.vault_auth_mount, "tfc")}/${item.vault_role_name}" => {
      vault_role_name      = coalesce(item.vault_role_name, item.vault_role)
      vault_role_path = "${coalesce(item.vault_auth_mount, "tfc")}/${item.vault_role_name}"
      vault_namespace      = item.vault_namespace
      vault_token_policies = item.vault_token_policies
      vault_auth_mount     = item.vault_auth_mount
      vault_auth_mount_key = "${item.vault_namespace}/${item.vault_auth_mount}"

      vault_namespace_key     = item.vault_namespace
      claim_organization_part = item.tfc_organization_name
      claim_project_part      = item.tfc_project_name
      claim_workspace_part    = item.tfc_workspace_name
      user_claim              = coalesce(item.user_claim, var.default_user_claim)

      tfc_organization_id   = item.tfc_organization_id,
      tfc_organization_name = item.tfc_organization_name,
      tfc_project_id        = item.tfc_project_id
      tfc_project_name      = item.tfc_project_name
      tfc_workspace_id      = item.tfc_workspace_id
      tfc_workspace_name    = item.tfc_workspace_name

      vault_auth_mount = coalesce(item.vault_auth_mount, var.auth_mount_path)

      identity_name = format(var.identity_name_format, item.tfc_organization_name, item.tfc_workspace_name, item.tfc_workspace_id)

      # token settings
      token_ttl         = try(item.token_ttl, var.default_token_ttl)
      token_max_ttl     = try(item.token_max_ttl, var.default_token_max_ttl)
      token_num_uses    = try(item.token_num_uses, var.default_token_num_uses)
      token_type        = try(item.token_type, var.default_token_type)
      token_bound_cidrs = try(item.token_bound_cidrs, var.default_token_bound_cidrs)

      # quotas
      enable_quota = try(item.quota, null) != null ? true : false
      quota_path = "${coalesce(var.auth_mount_path, "tfc")}-${item.vault_role_name}"

      max_leases = try(item.quota.max_leases, var.default_max_leases)
      rate = try(item.quota.default_rate_limit_rate, var.default_rate_limit_rate)
      interval = try(item.quota.default_rate_limit_interval, var.default_rate_limit_interval)
      block_interval = try(item.quota.default_rate_limit_block_interval, var.default_rate_limit_block_interval)

    } if item.vault_role_name != null
  })

  roles = merge(local.shared_roles, local.workspaced_roles)


  workspaces = {
    for r in distinct([
      for item in var.tfc_workspaces : {

        # # identity
        vault_entity_name  = format(var.identity_name_format, item.tfc_organization_name, item.tfc_workspace_name, item.tfc_workspace_id)
        vault_entity_alias = "organization:${item.tfc_organization_name}:project:${item.tfc_project_name}:workspace:${item.tfc_workspace_name}"

        # # Auth mount role settings
        vault_token_policies = lookup(item, "token_policies", []),
        vault_namespace      = item.vault_namespace
        vault_namespace_key  = item.vault_namespace
        vault_auth_mount_key = "${item.vault_namespace}/${item.vault_auth_mount}"

        # vault_role_name      = coalesce(item.tfc_vault_run_role, "${item.tfc_workspace_name}-${item.tfc_workspace_id}")

        # user_claim = coalesce(item.user_claim, var.default_user_claim)
        key = "${item.vault_namespace}/${item.tfc_organization_id}/${item.tfc_workspace_id}"
      }
    ]) : r.key => r
  }
}


# workspaces = {
#     for r in distinct([
#       for item in var.tfc_workspaces : {
#         tfc_organization_id   = item.tfc_organization_id,
#         tfc_organization_name = item.tfc_organization_name,
#         tfc_project_id        = item.tfc_project_id
#         tfc_project_name      = item.tfc_project_name
#         tfc_workspace_id      = item.tfc_workspace_id
#         tfc_workspace_name    = item.tfc_workspace_name

#         # identity
#         tfc_workspace_entity_alias = "organization:${item.tfc_organization_name}:project:${item.tfc_project_name}:workspace:${item.tfc_workspace_name}"
#         vault_identity_name        = ""

#         # Auth mount role settings
#         vault_token_policies = lookup(item, "token_policies", []),
#         vault_namespace      = try(item.tfc_vault_namespace, "${item.vault_namespace}")
#         vault_namespace_key  = try(item.tfc_vault_namespace, "${item.vault_namespace}")
#         vault_role_name      = try(item.tfc_vault_run_role, "${item.tfc_workspace_name}-${item.tfc_workspace_id}")
#         vault_auth_mount      = try(item.vault_auth_mount, var.auth_mount_path)
#         # vault_role_name      = format(var.role_name_format, org, ws)

#         user_claim = try(item.user_claim, var.default_user_claim)

#         # token settings
#         token_ttl         = try(item.token_ttl, var.default_token_ttl)
#         token_max_ttl     = try(item.token_max_ttl, var.default_token_max_ttl)
#         token_num_uses    = try(item.token_num_uses, var.default_token_num_uses)
#         token_type        = try(item.token_type, var.default_token_type)
#         token_bound_cidrs = try(item.token_bound_cidrs, var.default_token_bound_cidrs)

#         key = try(item.key, "${item.vault_namespace}/${item.tfc_workspace_id}")
#       }
#     ]) : r.key => r
#   }
