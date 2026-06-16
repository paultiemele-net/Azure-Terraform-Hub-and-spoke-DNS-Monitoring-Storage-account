# Storage account

resource "azurerm_storage_account" "storage_mex" {
  name                     = "storagemex1"
  resource_group_name      = azurerm_resource_group.rg3.name
  location                 = azurerm_resource_group.rg3.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  public_network_access_enabled = false
}
#  Creation of Private Endpoint accessible only by the subnet_frontend_mex 
resource "azurerm_private_endpoint" "storage_pe_mex" {
  name                = "pe-storage-mex"
  location            = azurerm_resource_group.rg3.location
  resource_group_name = azurerm_resource_group.rg3.name
  subnet_id           = azurerm_subnet.subnet_frontend_mex.id
#Connection to the file share
  private_service_connection {
    name                           = "psc-storage-mex"
    private_connection_resource_id = azurerm_storage_account.storage_mex.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "storage-file-dns-zone-group"

    private_dns_zone_ids = [
      azurerm_private_dns_zone.private_dns_sta_mex.id
    ]
  }
}

#Creation of the file share 
resource "azurerm_storage_share" "fileshare_mex" {
  name               = "files-mexico"
  storage_account_name = azurerm_storage_account.storage_mex.name
  quota              = 50
}

# Storage account rules to allow access only to subnet_frontend1_cus- Service Endpoint

#resource "azurerm_storage_account_network_rules" "storage_rules_cus" {
#  storage_account_id = azurerm_storage_account.storage_mex.id
#
#  default_action = "Deny"

#  virtual_network_subnet_ids = [
#    azurerm_subnet.subnet_frontend_cus.id
#  ]
#
#  bypass = ["AzureServices"]
#}