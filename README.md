## Equinix Fabric L2 Connection To Google Cloud Interconnect Terraform module

[![Experimental](https://img.shields.io/badge/Stability-Experimental-red.svg)](https://github.com/equinix-labs/standards#about-uniform-standards)
[![terraform](https://github.com/equinix-labs/terraform-equinix-template/actions/workflows/integration.yaml/badge.svg)](https://github.com/equinix-labs/terraform-equinix-template/actions/workflows/integration.yaml)

`terraform-equinix-network-edge-nginx` is a Terraform module that utilizes [Terraform provider for Equinix](https://registry.terraform.io/providers/equinix/equinix/latest) and [Terraform provider for Google](https://registry.terraform.io/providers/hashicorp/google/latest/docs) to to create Network Edge NGINX device.


This module creates a NGINX single device, HA pair and Cluster based on configuration.
### Usage

This project is experimental and supported by the user community. Equinix does not provide support for this project.

Install Terraform using the official guides at <https://learn.hashicorp.com/tutorials/terraform/install-cli>.

This project may be forked, cloned, or downloaded and modified as needed as the base in your integrations and deployments.

This project may also be used as a [Terraform module](https://learn.hashicorp.com/collections/terraform/modules).

To use this module in a new project, create a file such as:

```hcl
# main.tf
provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "nginx-single" {
  source                 = "equinix-labs/network-edge-device-nginx/equinix"
  name                   = "terraform-test-NGINX"
  hostname               = "terraform-nginx"
  metro_code             = var.metro_code_primary
  account_number         = "123456"
  platform               = "small"
  software_package       = "STD"
  term_length            = 1
  notifications          = ["test@test.com"]
  additional_bandwidth   = 50
  mgmt_acl_template_uuid = equinix_network_acl_template.nginx-pri.id
  ssh_key = {
    userName = "johndoe"
    keyName  = equinix_network_ssh_key.johndoe.name
  }
}

```

Run `terraform init -upgrade` and `terraform apply`.

### Variables

See <https://registry.terraform.io/modules/equinix-labs/network-edge-device-nginx/equinix/latest?tab=inputs> for a description of all variables.

### Outputs

See <https://registry.terraform.io/modules/equinix-labs/network-edge-device-nginx/equinix/latest?tab=outputs> for a description of all outputs.

### Resources

| Name | Type |
|------|------|
| [equinix_network_device.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_device) | resource |
| [equinix_network_device_type.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_type) | data source |
| [equinix_network_device_platform.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_platform) | data source |
| [equinix_network_device_software.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_software) | data source |

### Examples

- [Network Edge NGINX single device](https://registry.terraform.io/modules/equinix-labs/network-edge-device-nginx/equinix/latest/examples/nginx-single/)
- [Network Edge NGINX HA pair device](https://registry.terraform.io/modules/equinix-labs/network-edge-device-nginx/equinix/latest/examples/nginx-ha/)
- [Network Edge cluster device](https://registry.terraform.io/modules/equinix-labs/network-edge-device-nginx/equinix/latest/examples/nginx-cluster/)