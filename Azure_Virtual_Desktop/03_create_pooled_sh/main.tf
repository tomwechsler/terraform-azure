# Create a new pooled host pool
locals {
  host_pool_name      = "${var.prefix}-W10-Pool"
  session_host_prefix = "${var.prefix}-Pool"
  base_name           = "${var.prefix}-W10-Pool"
}

resource "azurerm_resource_group" "host_pool" {
  name     = local.base_name
  location = var.location
}

resource "azurerm_virtual_desktop_host_pool" "pooled" {
  location            = azurerm_resource_group.host_pool.location
  resource_group_name = azurerm_resource_group.host_pool.name

  name                     = local.host_pool_name
  validate_environment     = false
  description              = "Acceptance Test: A pooled host pool - pooledBreadthFirst"
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;targetisaadjoined:i:1;"
  type                     = "Pooled"
  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 10
  start_vm_on_connect      = true
}

resource "azurerm_virtual_desktop_workspace" "pooled" {
  name                = "${local.host_pool_name}-westeurope"
  location            = azurerm_resource_group.host_pool.location
  resource_group_name = azurerm_resource_group.host_pool.name
}

resource "azurerm_virtual_desktop_application_group" "desktopapp" {
  name                = "${local.host_pool_name}-DAG"
  location            = azurerm_resource_group.host_pool.location
  resource_group_name = azurerm_resource_group.host_pool.name

  type         = "Desktop"
  host_pool_id = azurerm_virtual_desktop_host_pool.pooled.id
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "desktopapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.pooled.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopapp.id
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "pooled" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.pooled.id
  expiration_date = timeadd(timestamp(), "24h")
}

data "azurerm_subnet" "poolSubnet" {
  name                 = "poolSubnet"
  virtual_network_name = var.hub_vnet_name
  resource_group_name  = var.hub_vnet_resource_group
}

# Add a session host to the host pool
module "session_host" {
  source = "./session_host"

  resource_group  = azurerm_resource_group.host_pool.name
  location        = azurerm_resource_group.host_pool.location
  admin_password  = var.session_host_admin_password
  admin_username  = var.session_host_admin_username
  subnet_id       = data.azurerm_subnet.poolSubnet.id
  vm_name         = local.session_host_prefix
  image_offer     = var.image_offer
  image_publisher = var.image_publisher
  image_sku       = var.image_sku
  image_version   = var.image_version
  domain          = var.session_host_domain
  domainuser      = var.session_host_domainuser
  domainpassword  = var.session_host_domainpassword
  oupath          = var.session_host_oupath
  regtoken        = azurerm_virtual_desktop_host_pool_registration_info.pooled.token
  hostpoolname    = azurerm_virtual_desktop_host_pool.pooled.name

}

# Required for Start VM on Connect
data "azurerm_subscription" "primary" {}

data "azuread_service_principal" "avd" {
  application_id = "9cdead84-a844-4324-93f2-b2e6bb768d07"
}