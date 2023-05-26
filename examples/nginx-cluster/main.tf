provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "nginx-cluster" {
  source                 = "equinix-labs/network-edge-device-nginx/equinix"
  name                   = "terraform-test-NGINX-cluster"
  hostname               = "nginx-test"
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
  cluster = {
    enabled                             = true
    name                                = "test-nginx-cluster"
    node0_vendor_configuration_hostname = "nginx-pri"
    node1_vendor_configuration_hostname = "nginx-sec"
  }
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-cluster"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDpXGdxljAyPp9vH97436U171cX2gRkfPnpL8ebrk7ZBeeIpdjtd8mYpXf6fOI0o91TQXZTYtjABzeRgg6/m9hsMOnTHjzWpFyuj/hiPuiie1WtT4NffSH1ALQFX//zouBLmdNiYFMLfEVPZleergAqsYOHGCiQuR6Qh5j0yc5Wx+LKxiRZyjsSqo+EB8V6xBXi2i5PDJXK+dYG8YU9vdNeQdB84HvTWcGEnLR5w7pgC74pBVwzs3oWLy+3jWS0TKKtflmryeFRufXq87gEkC1MOWX88uQgjyCsemuhPdN++2WS57gu7vcqCMwMDZa7dukRS3JANBtbs7qQhp9Nw2PB4q6tohqUnSDxNjCqcoGeMNg/0kHeZcoVuznsjOrIDt0HgUApflkbtw1DP7Epfc2MJ0anf5GizM8UjMYiXEvv2U/qu8Vb7d5bxAshXM5nh67NSrgst9YzSSodjUCnFQkniz6KLrTkX6c2y2gJ5c9tWhg5SPkAc8OqLrmIwf5jGoHGh6eUJy7AtMcwE3iUpbrLw8EEoZDoDXkzh+RbOtSNKXWV4EAXsIhjQusCOWWQnuAHCy9N4Td0Sntzu/xhCZ8xN0oO67Cqlsk98xSRLXeg21PuuhOYJw0DLF6L68zU2OO0RzqoNq/FjIsltSUJPAIfYKL0yEefeNWOXSrasI1ezw== john@hades"
}

resource "equinix_network_acl_template" "nginx-cluster" {
  name        = "tf-nginx-cluster"
  description = "Cluster NGINX ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
