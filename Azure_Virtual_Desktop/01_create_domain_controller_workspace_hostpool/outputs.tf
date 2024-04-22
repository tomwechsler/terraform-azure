output "dc_admin_password" {
  value = nonsensitive(module.azure_dc.windows_vm_password)
}

output "dc_public_ip_address" {
  value = module.azure_dc.windows_vm_public_ips
}

output "dc_private_ip_address" {
  value = var.dc_private_ip_address
}

output "dc_domain" {
  value = var.dc_ad_domain_name
}

output "vnet_id" {
  value = azurerm_virtual_network.hubrg.id
}

output "vnet_name" {
  value = azurerm_virtual_network.hubrg.name
}

output "vnet_resource_group" {
  value = azurerm_resource_group.hubrg.name
}

output "subnets" {
  value = { for subnet in azurerm_subnet.subnets : subnet.name => subnet.id }
}

output "azure_virtual_desktop_host_pool" {
  description = "Name of the Azure Virtual Desktop host pool"
  value       = azurerm_virtual_desktop_host_pool.hostpool.name
}

output "azurerm_virtual_desktop_application_group" {
  description = "Name of the Azure Virtual Desktop DAG"
  value       = azurerm_virtual_desktop_application_group.dag.name
}

output "azurerm_virtual_desktop_workspace" {
  description = "Name of the Azure Virtual Desktop workspace"
  value       = azurerm_virtual_desktop_workspace.workspace.name
}