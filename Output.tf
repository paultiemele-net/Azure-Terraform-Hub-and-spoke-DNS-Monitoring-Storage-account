# =========================
# Outputs
# =========================

# Firewall Private IP
output "firewall_private_ip_mex" {
  value = azurerm_firewall.firewall_mex.ip_configuration[0].private_ip_address
}

# Bastion Public IP
output "bastion_public_ip_cus" {
  value = azurerm_public_ip.bastion_pip_cus.ip_address
}

# Storage Account Name
output "storage_account_name_mex" {
  value = azurerm_storage_account.storage_mex.name
}

# Storage File Share Name
output "storage_fileshare_name_mex" {
  value = azurerm_storage_share.fileshare_mex.name
}

# CUS VM Private IPs
output "vm_private_ips_cus" {
  value = [
    for nic in azurerm_network_interface.nic :
    nic.private_ip_address
  ]
}

# NCUS VM Private IPs
output "vm_private_ips_ncus" {
  value = [
    for nic in azurerm_network_interface.nic_ncus :
    nic.private_ip_address
  ]
}

# MEX VM Private IPs
output "vm_private_ips_mex" {
  value = [
    for nic in azurerm_network_interface.nic_mex :
    nic.private_ip_address
  ]
}

# VNet IDs
output "vnet_cus_id" {
  value = azurerm_virtual_network.vnet_cus.id
}

output "vnet_ncus_id" {
  value = azurerm_virtual_network.vnet_ncus.id
}

output "vnet_mex_id" {
  value = azurerm_virtual_network.vnet_mex.id
}

# Private Endpoint IP
output "storage_private_endpoint_ip_mex" {
  value = azurerm_private_endpoint.storage_pe_mex.private_service_connection[0].private_ip_address
}