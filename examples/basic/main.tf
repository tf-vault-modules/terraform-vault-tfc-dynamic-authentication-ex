module "vault_tfc_backends" {
  source = "../.."

  tfc_workspaces = var.tfc_workspaces
}
