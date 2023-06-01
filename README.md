<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 3.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_identity_entity.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity) | resource |
| [vault_identity_entity_alias.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity_alias) | resource |
| [vault_jwt_auth_backend.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_description"></a> [auth\_description](#input\_auth\_description) | JWT Auth Backend Description | `string` | `"Terraform Managed Auth Mount"` | no |
| <a name="input_auth_mount_path"></a> [auth\_mount\_path](#input\_auth\_mount\_path) | Vault JWT TFC Authentication path for the namespace | `string` | `"tfc"` | no |
| <a name="input_auth_mount_tune"></a> [auth\_mount\_tune](#input\_auth\_mount\_tune) | Authentication mount tune | <pre>object({<br>    default_lease_ttl            = optional(string)<br>    max_lease_ttl                = optional(string)<br>    audit_non_hmac_response_keys = optional(string)<br>    audit_non_hmac_request_keys  = optional(string)<br>    listing_visibility           = optional(string)<br>    passthrough_request_headers  = optional(string)<br>    allowed_response_headers     = optional(string)<br>    token_type                   = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_auth_token_issuer"></a> [auth\_token\_issuer](#input\_auth\_token\_issuer) | Vault JWT TFC Authentication path for the namespace | `string` | `"https://app.terraform.io"` | no |
| <a name="input_bound_audiences"></a> [bound\_audiences](#input\_bound\_audiences) | List of audiences to be allowed for JWT auth roles | `list(string)` | <pre>[<br>  "vault.workload.identity"<br>]</pre> | no |
| <a name="input_claim_mappings"></a> [claim\_mappings](#input\_claim\_mappings) | Mapping of claims to metadata | `map(string)` | <pre>{<br>  "terraform_apply_phase": "terraform_apply_phase",<br>  "terraform_full_workspace": "terraform_full_workspace",<br>  "terraform_organization_id": "terraform_organization_id",<br>  "terraform_organization_name": "terraform_organization_name",<br>  "terraform_project_id": "terraform_project_id",<br>  "terraform_project_name": "terraform_project_name",<br>  "terraform_run_id": "terraform_run_id",<br>  "terraform_run_phase": "terraform_run_phase",<br>  "terraform_workspace_id": "terraform_workspace_id",<br>  "terraform_workspace_name": "terraform_workspace_name"<br>}</pre> | no |
| <a name="input_default_token_bound_cidrs"></a> [default\_token\_bound\_cidrs](#input\_default\_token\_bound\_cidrs) | Default token\_bound\_cidrs | `list` | `[]` | no |
| <a name="input_default_token_display_name"></a> [default\_token\_display\_name](#input\_default\_token\_display\_name) | Vault Token display name | `string` | `"tfc-auth-vending-admin"` | no |
| <a name="input_default_token_max_ttl"></a> [default\_token\_max\_ttl](#input\_default\_token\_max\_ttl) | Default token\_max\_ttl | `number` | `3600` | no |
| <a name="input_default_token_num_uses"></a> [default\_token\_num\_uses](#input\_default\_token\_num\_uses) | Default token\_num\_uses | `number` | `0` | no |
| <a name="input_default_token_ttl"></a> [default\_token\_ttl](#input\_default\_token\_ttl) | Default token\_ttl | `number` | `60` | no |
| <a name="input_default_token_type"></a> [default\_token\_type](#input\_default\_token\_type) | Default token\_type | `string` | `"service"` | no |
| <a name="input_default_user_claim"></a> [default\_user\_claim](#input\_default\_user\_claim) | The claim to use to uniquely identify the user; this will be used as the name for the Identity entity alias created due to a successful login. | `string` | `"terraform_full_workspace"` | no |
| <a name="input_default_vault_address"></a> [default\_vault\_address](#input\_default\_vault\_address) | Default Vault address | `string` | `"http://localhost:8200"` | no |
| <a name="input_default_vault_token"></a> [default\_vault\_token](#input\_default\_vault\_token) | Default Vault token | `string` | `"root"` | no |
| <a name="input_identity_name_format"></a> [identity\_name\_format](#input\_identity\_name\_format) | Identity name format string. Will look like tfc-organization-workspace\_name | `string` | `"tfc-%[1]s-%[2]s-%[3]s"` | no |
| <a name="input_role_name_format"></a> [role\_name\_format](#input\_role\_name\_format) | Format string to generate Vault role name. The first parameter is the organization, and the second is the workspace name | `string` | `"%[1]s-%[2]s"` | no |
| <a name="input_tfc_shared_roles"></a> [tfc\_shared\_roles](#input\_tfc\_shared\_roles) | List of shared roles | <pre>list(object({<br>    vault_namespace         = optional(string)<br>    vault_token_policies    = list(string)<br>    vault_auth_mount        = optional(string)<br>    tfc_organization_name   = optional(string)<br>    tfc_project_name        = optional(string)<br>    tfc_workspace_name      = optional(string)<br>    tfc_organization_id     = optional(string)<br>    tfc_project_id          = optional(string)<br>    tfc_workspace_ids       = optional(list(string))<br>    claim_project_part      = optional(string)<br>    claim_organization_part = optional(string)<br>    claim_workspace_part    = optional(string)<br>    user_claim              = optional(string)<br>    vault_role_name         = optional(string)<br>    vault_role              = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tfc_workspaces"></a> [tfc\_workspaces](#input\_tfc\_workspaces) | List of Terraform cloud workspaces to be authorized | <pre>list(object({<br>    vault_namespace       = string<br>    vault_token_policies  = list(string)<br>    vault_auth_mount      = optional(string)<br>    tfc_organization_name = optional(string)<br>    tfc_project_name      = optional(string)<br>    tfc_workspace_name    = optional(string)<br>    tfc_organization_id   = optional(string)<br>    tfc_project_id        = optional(string)<br>    tfc_workspace_id      = optional(string)<br>    claim_workspace_part  = optional(string)<br>    user_claim            = optional(string)<br>    vault_role_name       = optional(string)<br>    vault_role            = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | Vault namespace to execute this module | `string` | `"admin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backends"></a> [backends](#output\_backends) | List of Vault TFC Backends |
| <a name="output_namespaces"></a> [namespaces](#output\_namespaces) | List of all Vault namespaces |
| <a name="output_roles"></a> [roles](#output\_roles) | List of all TFC Vault roles |
| <a name="output_workspaces"></a> [workspaces](#output\_workspaces) | List of all authorized TFC Workspaces |
<!-- END_TF_DOCS -->