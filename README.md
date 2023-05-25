# terraform-vault-dnb_vault-tfc-auth-vending




## Quick Start

Vault Module for vending TFC Workspaces JWT Authentication Vault Backend

Will create in Vault child namespaces: 

* JWT Auth Backend
* Roles with jwt claim to authorize only certain namespaces
* Policy that will be assigned to that login

Claim will authorize only one workspace:

```
  bound_claims = {
    sub = "organization:${each.value.tfc_organization_name}:project:${each.value.tfc_project_name}:workspace:${each.value.tfc_workspace_name}:run_phase:*"
  }
```

Claim will authorize multiple workspaces:

```
  bound_claims = {
    sub = "organization:${each.value.tfc_organization_name}:project:${each.value.tfc_project_name}:workspace:*NAME:run_phase:*"
  }
```

Claim will authorize workspaces from one project:

```
  bound_claims = {
    sub = "organization:${each.value.tfc_organization_name}:project:${each.value.tfc_project_name}:workspace:*:run_phase:*"
  }
```



Test module locally:
```
make test
```

Apply configuration to currently configured/authenticated AWS ENV:
```
make test-apply
```

## Module Documentation
[Terraform docs](https://github.com/terraform-docs/terraform-docs) is used to ensure proper module documentation.

## Contributing

### Required Providers

The template repo contains a few required providers for the module repo, which specify module version ranges in the `./versions.tf` file. Versions will be updated and maintained by Dependabot. If unneeded for the given module, remove from the `./versions.tf` file in order to prevent unnecessary provider downloads during `terraform init`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| [vault_jwt_auth_backend.tfc](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_policy.workspace_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tfc_jwt_auth_default_path"></a> [tfc\_jwt\_auth\_default\_path](#input\_tfc\_jwt\_auth\_default\_path) | Vault JWT TFC Authentication path for the namespace | `string` | `"tfc"` | no |
| <a name="input_tfc_workspaces"></a> [tfc\_workspaces](#input\_tfc\_workspaces) | Input for this module. List of workspaces | <pre>map(object({<br>    tfc_organization_id   = string<br>    tfc_organization_name = string<br>    tfc_project_id        = string<br>    tfc_project_name      = string<br>    tfc_workspace_id      = string<br>    tfc_workspace_name    = string<br>    drn                   = string<br>    environment           = string<br>    token_policies        = list(string)<br>    # vault_namespace_path  = optional(string, null)<br>    vault_role_name = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | Vault namespace to execute this module | `string` | `"admin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspaces"></a> [workspaces](#output\_workspaces) | List of all authorized TFC Workspaces |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
