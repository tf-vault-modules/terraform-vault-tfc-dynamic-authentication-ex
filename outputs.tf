output "namespaces" {
  value       = local.namespaces
  description = "List of all Vault namespaces"
}

output "workspaces" {
  value       = local.workspaces
  description = "List of all authorized TFC Workspaces"
}
