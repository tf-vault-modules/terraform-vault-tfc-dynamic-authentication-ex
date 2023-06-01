tfc_workspaces = [{
  vault_role_name : "test-role",
  vault_auth_mount : "jwt-tfc",
  entity_name : "test-ws-name-1",

  tfc_organization_id : "test-org-ir",
  tfc_organization_name : "test-org",
  tfc_project_id : "tfc-test-project-id",
  tfc_project_name : "Test Project",
  tfc_workspace_id : "workspace1",
  tfc_workspace_name : "ws-test-name-1",

  vault_namespace = "root"
  vault_token_policies : ["tfc-workspace-policy"], }
]