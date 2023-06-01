#------------------------------------------------------------------------------
# To leverage more than one namespace, define a vault provider per namespace
#------------------------------------------------------------------------------
provider "vault" {
  token_name = var.default_token_display_name
  # address    = var.default_vault_address
  # token      = var.default_vault_token
}
