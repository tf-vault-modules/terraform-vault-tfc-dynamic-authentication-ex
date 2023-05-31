output "namespaces" {
  value       = local.namespaces
  description = "List of all Vault namespaces"
}

output "backends" {
  value       = local.backends
  description = "List of Vault TFC Backends"
}

output "roles" {
  value       = local.roles
  description = "List of all TFC Vault roles"
}

output "workspaces" {
  value       = local.workspaces
  description = "List of all authorized TFC Workspaces"
}
