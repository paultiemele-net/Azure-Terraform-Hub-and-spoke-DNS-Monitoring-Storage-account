#4 Firewall

resource "azurerm_public_ip" "firewall_pip_mex" {
  name                = "pip-fw-mex"
  location            = azurerm_resource_group.rg3.location
  resource_group_name = azurerm_resource_group.rg3.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall_mex" {
  name                = "fw-mex"
  location            = azurerm_resource_group.rg3.location
  resource_group_name = azurerm_resource_group.rg3.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"
  
  #Associate the firewall policy to the Firewall
  firewall_policy_id = azurerm_firewall_policy.fw_policy_mex.id

  ip_configuration {
    name                 = "fw-mex-ipconfig"
    subnet_id            = azurerm_subnet.firewall_subnet_mex.id
    public_ip_address_id = azurerm_public_ip.firewall_pip_mex.id
  }
}

#Creation of the Firewall policy associated to the Firewall at line 318
resource "azurerm_firewall_policy" "fw_policy_mex" {
  name                = "fw-policy-mex"
  resource_group_name = azurerm_resource_group.rg3.name
  location            = azurerm_resource_group.rg3.location
}

#Creation of Rules for the Firewall
resource "azurerm_firewall_policy_rule_collection_group" "fw_policy_rules_mex" {
  name               = "fw-policy-rules-mex"
  firewall_policy_id = azurerm_firewall_policy.fw_policy_mex.id
  priority           = 100

  network_rule_collection {
    name     = "allow-spoke-to-spoke"
    priority = 100
    action   = "Allow"

    rule {
      name                  = "allow-cus-to-ncus"
      protocols             = ["Any"]
      source_addresses      = ["10.0.2.0/24"]
      destination_addresses = ["10.1.2.0/24"]
      destination_ports     = ["*"]
    }

    rule {
      name                  = "allow-ncus-to-cus"
      protocols             = ["Any"]
      source_addresses      = ["10.1.2.0/24"]
      destination_addresses = ["10.0.2.0/24"]
      destination_ports     = ["*"]
    }
  }
}


# Route table CUS-MEX

resource "azurerm_route_table" "rt_cus" {
  name                = "rt-cus"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

#Associate the Subnet that I want from the Spoke to the Route table
resource "azurerm_subnet_route_table_association" "cus_backend1_rt" {
  subnet_id      = azurerm_subnet.subnet_backend1_cus.id
  route_table_id = azurerm_route_table.rt_cus.id
}
#Route Configuration 
resource "azurerm_route" "route_to_firewall_cus_mex_ncus" {
  name                   = "route-fw-cus_mex_ncus"
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.rt_cus.name

  address_prefix         = "10.1.2.0/24"

  next_hop_type          = "VirtualAppliance"

  next_hop_in_ip_address = azurerm_firewall.firewall_mex.ip_configuration[0].private_ip_address
}

# Route table NCUS-MEX

resource "azurerm_route_table" "rt_ncus" {
  name                = "rt-ncus"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
}

resource "azurerm_subnet_route_table_association" "ncus_backend1_rt" {
  subnet_id      = azurerm_subnet.subnet_backend1_ncus.id
  route_table_id = azurerm_route_table.rt_ncus.id
}

resource "azurerm_route" "route_to_firewall_ncus_mex_cus" {
  name                   = "route-fw-ncus_mex_cus"
  resource_group_name    = azurerm_resource_group.rg2.name
  route_table_name       = azurerm_route_table.rt_ncus.name

  address_prefix         = "10.0.2.0/24"

  next_hop_type          = "VirtualAppliance"

  next_hop_in_ip_address = azurerm_firewall.firewall_mex.ip_configuration[0].private_ip_address

}