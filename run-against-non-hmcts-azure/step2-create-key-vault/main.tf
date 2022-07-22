terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

  use_msal = false
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = var.kv-name
  location            = var.location
  resource_group_name = var.rg-name

  sku_name  = var.sku
  tenant_id = data.azurerm_client_config.current.tenant_id

  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  soft_delete_retention_days      = 90
  purge_protection_enabled        = var.purge_protection_enabled

  network_acls {
    bypass                     = "AzureServices"
    default_action             = var.network_acls_default_action # Default is "Allow" for compatibility
    ip_rules                   = var.network_acls_allowed_ip_ranges
    virtual_network_subnet_ids = var.network_acls_allowed_subnet_ids
  }

  tags = var.common_tags
}

resource "azurerm_key_vault_access_policy" "creator_access_policy" {
  key_vault_id = azurerm_key_vault.kv.id

  object_id = data.azurerm_client_config.current.tenant_id
  tenant_id = data.azurerm_client_config.current.tenant_id

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "SetIssuers",
    "Update",
    "ManageContacts",
    "ManageIssuers",
  ]

  key_permissions = [
    "Create",
    "List",
    "Get",
    "Delete",
    "Update",
    "Import",
    "Backup",
    "Restore",
    "Decrypt",
    "Encrypt",
    "UnwrapKey",
    "WrapKey",
    "Sign",
    "Verify",
  ]

  secret_permissions = [
    "Set",
    "List",
    "Get",
    "Delete",
    "Recover",
    "Purge",
  ]
} 

resource "azurerm_key_vault_access_policy" "user_access_policy" {
  key_vault_id = azurerm_key_vault.kv.id

  object_id = var.user-object-id
  tenant_id = data.azurerm_client_config.current.tenant_id

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "SetIssuers",
    "Update",
    "ManageContacts",
    "ManageIssuers",
  ]

  key_permissions = [
    "Create",
    "List",
    "Get",
    "Delete",
    "Update",
    "Import",
    "Backup",
    "Restore",
    "Decrypt",
    "Encrypt",
    "UnwrapKey",
    "WrapKey",
    "Sign",
    "Verify",
  ]

  secret_permissions = [
    "Set",
    "List",
    "Get",
    "Delete",
    "Recover",
    "Purge",
  ]
} 

resource "azurerm_key_vault_secret" "github_api_key" {
  name         = "hmcts-github-apikey"
  value        = "testdata"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "db_manager_username" {
  name         = "db-manager-username"
  value        = "amdinistrator"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "db_manager_password" {
  name         = "db-manager-password"
  value        = "hbjhger876865sdsd233"
  key_vault_id = azurerm_key_vault.kv.id
}