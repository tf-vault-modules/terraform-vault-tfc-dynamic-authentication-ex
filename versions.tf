terraform {
  required_version = ">= 1.3.0"

  required_providers {
    # use minimum version pinning in modules. see https://www.terraform.io/docs/language/expressions/version-constraints.html#terraform-core-and-provider-versions
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.10.0"
    }
  }
}
