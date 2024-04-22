#Create the resource group
resource "azurerm_resource_group" "hubrg" {
  name     = "hub-rg-${var.azure_region}"
  location = var.azure_region
}

#Create the virtual network
resource "azurerm_virtual_network" "hubrg" {
  name                = "vnet-hub-${var.azure_region}"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.hubrg.name

  address_space = [var.vnet_hub_address_space]
  dns_servers   = [var.dc_private_ip_address]

}

#Create the subnets
resource "azurerm_subnet" "subnets" {
  for_each             = var.vnet_hub_subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.hubrg.name
  virtual_network_name = azurerm_virtual_network.hubrg.name
  address_prefixes     = [each.value]
}

module "azure_dc" {
  source = "./azure_dc"

  resource_group_name  = azurerm_resource_group.hubrg.name
  location             = azurerm_resource_group.hubrg.location
  virtual_network_name = azurerm_virtual_network.hubrg.name
  subnet_name          = "adSubnet"

  virtual_machine_name               = "dc01-hub"
  windows_distribution_name          = "windows2022dc"
  os_flavor                          = "windows"
  virtual_machine_size               = var.dc_virtual_machine_size
  admin_username                     = var.dc_admin_username
  private_ip_address_allocation_type = "Static"
  private_ip_address                 = [var.dc_private_ip_address]
  enable_public_ip_address           = true

  #Active Directory domain and netbios details
  #Intended for test/demo purposes
  #For production use of this module, fortify the security by adding correct nsg rules
  active_directory_domain       = var.dc_ad_domain_name
  active_directory_netbios_name = var.dc_ad_netbios_name

  nsg_inbound_rules = [
    {
      name                   = "rdp"
      destination_port_range = "3389"
      source_address_prefix  = "*"
    },

    {
      name                   = "dns"
      destination_port_range = "53"
      source_address_prefix  = "*"
    },
  ]

  depends_on = [
    azurerm_resource_group.hubrg,
    azurerm_subnet.subnets
  ]
}

#Create AVD workspace
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = var.workspace
  resource_group_name = azurerm_resource_group.hubrg.name
  location            = azurerm_resource_group.hubrg.location
  friendly_name       = "${var.prefix} Workspace"
  description         = "${var.prefix} Workspace"
}

#Create AVD host pool
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  resource_group_name      = azurerm_resource_group.hubrg.name
  location                 = azurerm_resource_group.hubrg.location
  name                     = var.hostpool
  friendly_name            = var.hostpool
  validate_environment     = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  description              = "${var.prefix} Terraform HostPool"
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "DepthFirst" #[BreadthFirst DepthFirst]
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool.id
  expiration_date = var.rfc3339
}

#Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = azurerm_resource_group.hubrg.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  location            = azurerm_resource_group.hubrg.location
  type                = "Desktop"
  name                = "${var.prefix}-dag"
  friendly_name       = "Desktop AppGroup"
  description         = "AVD application group"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}