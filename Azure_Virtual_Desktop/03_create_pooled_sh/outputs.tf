output "desktop_application_group_name" {
  value = azurerm_virtual_desktop_application_group.desktopapp.name
}

output "desktop_application_group_resource_group" {
  value = azurerm_virtual_desktop_application_group.desktopapp.resource_group_name
}