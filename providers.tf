#------------------------------------------------------------------------------
# To leverage more than one namespace, define a vault provider per namespace
#------------------------------------------------------------------------------
provider "vault" {
  token_name = "tfc-auth-vending-admin"
}
