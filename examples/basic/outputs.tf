output "namespaces" {
  value       = module.vault_tfc_backends.namespaces
  description = "List of all Vault namespaces"
}

output "backends" {
  value       = module.vault_tfc_backends.backends
  description = "List of all Vault backends"
}

output "roles" {
  value       = module.vault_tfc_backends.roles
  description = "List of all Vault TFC roles"
}

output "workspaces" {
  value       = module.vault_tfc_backends.workspaces
  description = "List of all authorized TFC Workspaces"

}

