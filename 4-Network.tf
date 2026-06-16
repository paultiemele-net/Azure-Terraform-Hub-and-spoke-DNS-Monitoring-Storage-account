# 1e Resource group avec 1 VNet divisé en 3 subnets

# Vnet
resource "azurerm_virtual_network" "vnet_cus" {
  name                = "vnet-CUS"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnets
resource "azurerm_subnet" "subnet_frontend_cus" {
  name                 = "subnet1-CUS"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_cus.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet_backend1_cus" {
  name                 = "subnet2-CUS"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_cus.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet_backend2_cus" {
  name                 = "subnet3-CUS"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_cus.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Bastion Subnet
resource "azurerm_subnet" "bastion_subnet_cus" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet_cus.name
  address_prefixes     = ["10.0.200.0/26"]
}

# 2e Resource group avec 1 VNet divisé en 3 subnets

# Vnet
resource "azurerm_virtual_network" "vnet_ncus" {
  name                = "vnet-NCUS"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  address_space       = ["10.1.0.0/16"]
}

# Subnets
resource "azurerm_subnet" "subnet_frontend_ncus" {
  name                 = "subnet1-NCUS"
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet_ncus.name
  address_prefixes     = ["10.1.1.0/24"]
  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "subnet_backend1_ncus" {
  name                 = "subnet2-NCUS"
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet_ncus.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "subnet_backend2_ncus" {
  name                 = "subnet3-NCUS"
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet_ncus.name
  address_prefixes     = ["10.1.3.0/24"]
}


# 3e Resource group avec 1 VNet divisé en 3 subnets

#Vnet
resource "azurerm_virtual_network" "vnet_mex" {
  name                = "vnet-MEX"
  location            = azurerm_resource_group.rg3.location
  resource_group_name = azurerm_resource_group.rg3.name
  address_space       = ["10.2.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "subnet_frontend_mex" {
  name                 = "subnet1-MEX"
  resource_group_name  = azurerm_resource_group.rg3.name
  virtual_network_name = azurerm_virtual_network.vnet_mex.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_subnet" "subnet_backend1_mex" {
  name                 = "subnet2-MEX"
  resource_group_name  = azurerm_resource_group.rg3.name
  virtual_network_name = azurerm_virtual_network.vnet_mex.name
  address_prefixes     = ["10.2.2.0/24"]
}

resource "azurerm_subnet" "subnet_backend2_mex" {
  name                 = "subnet3-MEX"
  resource_group_name  = azurerm_resource_group.rg3.name
  virtual_network_name = azurerm_virtual_network.vnet_mex.name
  address_prefixes     = ["10.2.3.0/24"]
}

resource "azurerm_subnet" "firewall_subnet_mex" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg3.name
  virtual_network_name = azurerm_virtual_network.vnet_mex.name
  address_prefixes     = ["10.2.100.0/26"]
}
