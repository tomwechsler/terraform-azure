terraform {
  required_version = "~>1.0"

  required_providers {
    azurerm = {
      version = "~>3.0"
      source  = "hashicorp/azurerm"
    }

    azuread = {
      version = "~>2.0"
      source  = "hashicorp/azuread"
    }
  }
}

provider "azurerm" {
  features {}
}