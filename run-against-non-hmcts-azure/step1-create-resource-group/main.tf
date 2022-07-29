terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99"
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

