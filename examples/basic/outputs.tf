output "namespaces" {
  value       = module.vault_tfc_backends.namespaces
  description = "List of all Vault namespaces"
}

output "workspaces" {
  value       = module.vault_tfc_backends.workspaces
  description = "List of all authorized TFC Workspaces"
}
