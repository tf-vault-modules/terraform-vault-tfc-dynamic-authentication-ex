variable "tfc_shared_roles" {
  default     = []
  type        = list(any)
  description = "List of workspaces to use TFC JTW Authentication"
}
variable "tfc_workspaces" {
  default     = []
  type        = list(any)
  description = "List of workspaces to use TFC JTW Authentication"
}
