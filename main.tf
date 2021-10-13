# locals
locals {
  common_tags = {
    owner              = var.owner
    purpose            = var.purpose
    ttl                = var.ttl
    terraform          = "true"
    tfe-workspace      = var.tfe-workspace
    lifecycle-action   = var.lifecycle-action
    config-as-code     = var.config-as-code
    repo               = var.repo
  }

  subnet_address_spaces = [{
    name          = "${var.owner}-${random_pet.pet.id}",
    address_space = cidrsubnet(var.vnet_address_space, 8, 0)
  }]

}

# Reference: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet
resource "random_pet" "pet" {
  length = 1
}

# Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
resource "azurerm_resource_group" "rg" {
  name     = "${var.owner}-${random_pet.pet.id}-resource-group"
  location = var.location
  tags     = local.common_tags
}

# Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.owner}-${random_pet.pet.id}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = [var.vnet_address_space]

  tags = local.common_tags
}

# Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "subnets" {
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  count                = length(local.subnet_address_spaces)
  name                 = "${var.owner}-${random_pet.pet.id}-${local.subnet_address_spaces[count.index].name}-subnet"
  address_prefixes     = [local.subnet_address_spaces[count.index].address_space]

  service_endpoints = [
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
  # NSG must be assigned twice. See issue https://github.com/terraform-providers/terraform-provider-azurerm/issues/2526
  # network_security_group_id = azurerm_network_security_group.networking.id
}
