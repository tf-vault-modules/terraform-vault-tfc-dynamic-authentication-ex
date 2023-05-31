module "vault_tfc_backends" {
  source = "../.."

  tfc_workspaces = var.tfc_workspaces
  tfc_shared_roles = var.tfc_shared_roles
}
