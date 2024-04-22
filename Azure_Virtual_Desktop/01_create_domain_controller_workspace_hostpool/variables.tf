variable "azure_region" {
  description = "(Optional) Region in which to deploy the hub network and DC. Defaults to West Europe."
  type        = string
  default     = "westeurope"
}

variable "vnet_hub_address_space" {
  description = "(Required) Address space used by the Hub Virtual Network"
  type        = string
}

variable "vnet_hub_subnets" {
  description = "(Required) Map of subnet names and address spaces for the Hub Virtual Network. One subnet MUST be named adSubnet and another must be name AzureFirewallSubnet."
  type        = map(string)
}

variable "dc_private_ip_address" {
  description = "(Required) Private IP Address to be used by the domain controller and for DNS of the Hub Virtual Network"
  type        = string
}

variable "dc_virtual_machine_size" {
  description = "(Optional) Virtual Machine size of DC. Defaults to Standard_D2s_v3"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "dc_admin_username" {
  description = "(Optional) Admin username for DC. Defaults to avdDCAdmin"
  type        = string
  default     = "avdDCAdmin"
}

variable "dc_ad_domain_name" {
  description = "(Required) FQDN of domain for the Hub DC"
  type        = string
}

variable "dc_ad_netbios_name" {
  description = "(Required) NETBIOS name for the Hub DC"
  type        = string
}

variable "workspace" {
  type        = string
  description = "Name of the Azure Virtual Desktop workspace"
  default     = "AVD-TF-Workspace"
}

variable "prefix" {
  type        = string
  default     = "avdtf"
  description = "Prefix of the name of the AVD machine(s)"
}

variable "hostpool" {
  type        = string
  description = "Name of the Azure Virtual Desktop host pool"
  default     = "AVD-TF-HP"
}

variable "rfc3339" {
  type        = string
  default     = "2024-04-30T12:43:13Z"
  description = "Registration token expiration"
}