#Locals is where we defined local variables to be used in the scope of this module.
locals {
  # Description of Conditial(ternary) operator
  # vaultName will be equal to var.key_vault_name if  var.key_vault_name is not empty,
  # otherwise it will be equal to infra-vault- + the value we give to subscription.
  vaultName = var.key_vault_name != "" ? var.key_vault_name : "infra-vault-${var.subscription}"
  vault_resource_group_name = var.key_vault_rg != "" ? var.key_vault_rg : (
    local.is_prod ? "core-infra-prod" : "cnp-core-infra"
  )
  default_name = var.component != "" ? "${var.product}-${var.component}" : var.product
  name         = var.name != "" ? var.name : local.default_name
  server_name  = "${local.name}-${var.env}"
}

data "azurerm_key_vault" "infra_vault" {
  name                = local.vaultName
  resource_group_name = local.vault_resource_group_name
}

resource "azurerm_resource_group" "data-resourcegroup" {
  name     = "${local.name}-data-${var.env}"
  location = var.location

  tags = var.common_tags
}

resource "random_password" "password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  number  = true
}

resource "azurerm_mssql_server" "mssql-paas" {
 name =  local.server_name
 location = var.location
 resource_group_name = azurerm_resource_group.data-resourcegroup.name
 version    = var.mssql_version
 administrator_login = var.mssql_user
 administrator_login_password = random_password.password.result

  tags = var.common_tags


  # UA- storage_mb = var.storage_mb
  # UA- backup_retention_days            = var.backup_retention_days
  # UA- geo_redundant_backup_enabled     = var.georedundant_backup
  # UA - ssl_enforcement_enabled          = true
  minimum_tls_version =  "1.2"
  public_network_access_enabled    = var.subnet_id == "" ? true : false
  # UA - auto_grow_enabled                = var.auto_grow_enabled

 #Azurerm_sql_active_directory_administrator deprecated in version 3.0
 # Instead for version 4.0 we define azuread_administrator inside the server ressource.
 # No more need to specify server name and ressource group name.
  azuread_administrator {
  login_username      = local.admin_group
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azuread_group.db_admin.object_id
  }
}

resource "azurerm_mssql_database" "mssql-db" {
  name                = replace(var.database_name, "-", "")
  # UA - resource_group_name = azurerm_resource_group.data-resourcegroup.name
  server_id =  azurerm_mssql_server.mssql-paas.id
  #UA -server_name         = azurerm_mssql_server.mssql-paas.name
  #UA -charset             = var.charset
  collation  = var.collation
  sku_name   = var.sku_name


}

locals {
  is_prod     = length(regexall(".*(prod).*", var.env)) > 0
  admin_group = local.is_prod ? "DTS Platform Operations SC" : "DTS Platform Operations"
  # psql needs spaces escaped in user names
  # mssql might not require those spaces
  # escaped_admin_group = replace(local.admin_group, " ", "\\ ")
}

data "azurerm_client_config" "current" {}

data "azuread_group" "db_admin" {
  display_name     = local.admin_group
  security_enabled = true
}

