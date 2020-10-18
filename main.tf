provider "azurerm" {
  version = "~>2.30.0"
  features {}
}

module "network" {
  source = "./network"

  # Resource group
  create_resource_group = true
  resource_group_name   = "my-dev"
  location              = "australiaeast"

  # Virtual network
  name           = "my-dev-network"
  address_spaces = ["10.0.0.0/16"]
  dns_servers    = ["20.20.20.20"]

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  aci_subnets     = ["10.0.128.0/24"]

  # Routes
  public_internet_route_next_hop_type          = "VirtualAppliance"
  public_internet_route_next_hop_in_ip_address = "AzureFirewall"

  # Firewall
  create_firewall = true
  firewall_subnet_address_prefixes = ["10.0.192.0/24"]
  # Tags
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
