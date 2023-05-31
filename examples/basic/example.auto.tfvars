# shared roles
tfc_shared_roles = [
  {
    vault_role_name = "project1"

    "vault_namespace" : "root/hr/salaries",
    "vault_token_policies" : ["default"],
    "vault_auth_mount" : "jwt-tfc-ex",

    tfc_organization_id: "org-wsG7g1dsNtVNFx7t"
    
    # claim
    claim_organization_part: "mag"
    claim_project_part: "*"
    claim_workspace_part: "*"

    tfc_workspace_ids = ["ws-BkNVuSbuMHwYErEj"]
  },
  {
    vault_role_name = "default_project"

    "vault_namespace" : "root",
    "vault_token_policies" : ["default"],
    "vault_auth_mount" : "jwt-tfc1",

    tfc_organization_id: "org-wsG7g1dsNtVNFx7t"
    
    # claim
    claim_organization_part: "mag"
    claim_project_part: "*"
    claim_workspace_part: "*"

    # tfc_workspace_ids = ["*"]
  }
]

tfc_workspaces = [

  {
    vault_role_name: "default_project2"
    vault_auth_mount: "jwt-tfc"
    entity_name: "workspace-ws-name-1",

    tfc_organization_id: "sample-org-ir",
    tfc_organization_name: "sample-org",
    tfc_project_id: "tfc-project-id",
    tfc_project_name: "Default Project",
    tfc_workspace_id: "workspace1",
    tfc_workspace_name: "ws-name-1",

    vault_namespace = "root"
    vault_token_policies: ["tfc-workspace-policy"],
  },
  {
    vault_role_name: "default_project4"
    vault_auth_mount: "jwt-tfc"
    entity_name: "workspace-ws-name-2",

    tfc_organization_id: "sample-org-ir",
    tfc_organization_name: "sample-org",
    tfc_project_id: "tfc-project-id",
    tfc_project_name: "Default Project",
    tfc_workspace_id: "workspace2",
    tfc_workspace_name: "ws-name-2",

    vault_namespace = "root"
    vault_token_policies: ["tfc-workspace-policy"],
  },
  {
    vault_role_name: "default_project3"
    vault_auth_mount: "jwt-tfc-ws"
    entity_name: "workspace-ws-name-1",

    tfc_organization_id: "sample-org-ir",
    tfc_organization_name: "sample-org",
    tfc_project_id: "tfc-project-id",
    tfc_project_name: "Default Project",
    tfc_workspace_id: "workspace3",
    tfc_workspace_name: "ws-name-3",

    vault_namespace = "root"
    vault_token_policies: ["tfc-workspace-policy"],
  },
  {
    vault_role: "default_project1"
    vault_namespace: "root"
    vault_auth_mount: "jwt-tfc"
    entity_name: "workspace-ws-name-4",

    tfc_organization_id: "sample-org-ir",
    tfc_organization_name: "sample-org",
    tfc_project_id: "tfc-project-id",
    tfc_project_name: "Default Project",
    tfc_workspace_id: "workspace4",
    tfc_workspace_name: "ws-name-4",

    
    vault_token_policies: ["tfc-workspace-policy"],
  }
]