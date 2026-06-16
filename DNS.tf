# Private DNS Zone for Vnet Mexico

# Private DNS Zone for Storage account - MEX VNet
resource "azurerm_private_dns_zone" "private_dns_sta_mex" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.rg3.name
}

# Link Private DNS Zone to MEX VNet
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_mex_link" {
  name                  = "link-dns-mex-vnet"
  resource_group_name   = azurerm_resource_group.rg3.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_sta_mex.name
  virtual_network_id    = azurerm_virtual_network.vnet_mex.id

  registration_enabled = false
}

# Private DNS Zone for VMs - MEX VNet
resource "azurerm_private_dns_zone" "internal_mex" {
  name                = "internal.mex.local"
  resource_group_name = azurerm_resource_group.rg3.name
}

# Link Private DNS Zone to MEX VNet
resource "azurerm_private_dns_zone_virtual_network_link" "internal_mex_link" {
  name                  = "internal-mex-link"
  resource_group_name   = azurerm_resource_group.rg3.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_mex.name
  virtual_network_id    = azurerm_virtual_network.vnet_mex.id

  registration_enabled = true
}