terraform {
  cloud {
    organization = "mag"

    workspaces {
      name = "testing-tfc"
    }
  }
}