module "database" {
  source             = "../../"
  product            = "hmcts-${var.product}"
  location           = var.location
  env                = var.env
  mssql_user         = "test-admin"
  database_name      = "test-db"
  mssql_version      = "12.0"
  sku_name           = "S0"//"GP_Gen5_4"
  sku_tier           = "GeneralPurpose"
  //storage_mb         = var.storage_mb
  common_tags        = var.common_tags
  subscription       = var.subscription
  sku_capacity       = 4
  key_vault_rg       = var.resource_group_name
  key_vault_name     = var.key_vault_name
}

resource "azurerm_key_vault_secret" "mssql-user" {
  name         = "bpm-MSSQL-USER"
  value        = module.database.user_name
  key_vault_id = data.azurerm_key_vault.key_vault.id //module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "mssql-password" {
  name         = "bpm-MSSQL-PASS"
  value        = module.database.mssql_password
  key_vault_id = data.azurerm_key_vault.key_vault.id //module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "mssql-host" {
  name         = "bpm-MSSQL-HOST"
  value        = module.database.host_name
  key_vault_id = data.azurerm_key_vault.key_vault.id //module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "mssql-port" {
  name         = "bpm-MSSQL-PORT"
  value        = module.database.mssql_listen_port
  key_vault_id = data.azurerm_key_vault.key_vault.id //module.vault.key_vault_id
}

resource "azurerm_key_vault_secret" "mssql-database" {
  name         = "bpm-MSSQL-DATABASE"
  value        = module.database.mssql_database
  key_vault_id = data.azurerm_key_vault.key_vault.id //module.vault.key_vault_id
}
