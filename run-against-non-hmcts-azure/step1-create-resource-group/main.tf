terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.32"
    }
  }
}

provider "azurerm" {
  features {}

  use_msal = false
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.location
}

