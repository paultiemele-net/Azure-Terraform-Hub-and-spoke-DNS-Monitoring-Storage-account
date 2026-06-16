# Vnet Peering from CUS to NCUS
resource "azurerm_virtual_network_peering" "mex_to_cus" {
  name                      = "peer-mex_to_cus"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_mex.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_cus.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

# Vnet Peering from MEX to NCUS
resource "azurerm_virtual_network_peering" "mex_to_ncus" {
  name                      = "peer-mex_to_ncus"
  resource_group_name       = azurerm_resource_group.rg2.name
  virtual_network_name      = azurerm_virtual_network.vnet_mex.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_ncus.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}