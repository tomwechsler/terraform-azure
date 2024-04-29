variable "location" {
  type        = string
  description = "(Optional) The Azure region where the resources should be created."
  default     = "westeurope"
}

variable "prefix" {
  type        = string
  description = "(Optional) The prefix for the name of the resources."
  default     = "avd"
}

variable "dc_private_ip_address" {
  type        = string
  description = "(Required) The private IP address of the DC in the hub network."
}

variable "hub_vnet_name" {
  type        = string
  description = "(Required) The name of the hub virtual network."
}

variable "hub_vnet_id" {
  type        = string
  description = "(Required) The ID of the hub virtual network."

}

variable "hub_vnet_resource_group" {
  type        = string
  description = "(Required) The name of the resource group for the hub virtual network."
}

# Variables for session hosts
variable "session_host_admin_username" {
  type        = string
  description = "(Required) The admin username for the session host."
}

variable "session_host_admin_password" {
  type        = string
  sensitive   = true
  description = "(Required) The admin password for the session host."

}

variable "session_host_domain" {
  type        = string
  description = "(Required) The AD domain for the session host."
}

variable "session_host_domainuser" {
  type        = string
  description = "(Required) The AD domain user for the session host."

}

variable "session_host_domainpassword" {
  type        = string
  sensitive   = true
  description = "(Required) The AD domain password for the session host."

}

variable "session_host_oupath" {
  type        = string
  description = "(Required) The OU path for the session host."
}

variable "image_publisher" {
  type        = string
  description = "(Optional) Image Publisher for session host. Defaults to MicrosoftWindowsDesktop."
  default     = "MicrosoftWindowsDesktop"
}

variable "image_offer" {
  type        = string
  description = "(Optional) Image Offer for session host. Defaults to Windows-10."
  default     = "Windows-10"
}

variable "image_sku" {
  type        = string
  description = "(Optional) Image SKU for session host. Defaults to win10-21h2-avd"
  default     = "win10-21h2-avd"
}

variable "image_version" {
  type        = string
  description = "(Optional) Image Version for session host. Defaults to latest."
  default     = "latest"
}