terraform {
  required_version = ">= 0.13"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "~> 2.0"
    }
  }
  provider_meta "equinix" {
    module_name = "terraform-equinix-network-edge-nginx"
  }
}
