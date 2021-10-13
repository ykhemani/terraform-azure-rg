output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_id" {
  value = azurerm_resource_group.rg.id
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_guid" {
  value = azurerm_virtual_network.vnet.guid
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet0_id" {
  value = azurerm_subnet.subnets[*].id
}

output "subnet0_name" {
  value = azurerm_subnet.subnets[*].name
}

output "subnet0_address_prefixes" {
  value = azurerm_subnet.subnets[*].address_prefixes
}
