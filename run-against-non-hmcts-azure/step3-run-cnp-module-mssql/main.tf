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

locals {
  vault_name = "${var.product}-${var.env}-kv"
}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name//"${var.raw_product}-${var.env}"
  resource_group_name = var.resource_group_name//"${var.raw_product}-${var.env}"
}
