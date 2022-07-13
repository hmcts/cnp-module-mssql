locals {
  db_reader_user = local.is_prod ? "DTS JIT Access ${var.product} DB Reader SC" : "DTS ${var.business_area} DB Access Reader"
}

resource "null_resource" "set-user-permissions" {
  triggers = {
    script_hash    = filesha256("${path.module}/set-mssql-permissions.bash")
    name           = local.name
    db_reader_user = local.db_reader_user
  }

  provisioner "local-exec" {
    command = "${path.module}/set-mssql-permissions.bash"

    environment = {
      DB_NAME                       = replace(var.database_name, "-", "")
      # DB_HOST_NAME                  = azurerm_mssql_server.mssql-paas.fqdn
      # DB_USER                       = "${local.escaped_admin_group}@${azurerm_mssql_server.mssql-paas.name}"
      DB_READER_USER                = local.db_reader_user
      AZURE_SUBSCRIPTION_SHORT_NAME = var.subscription
      DB_MANAGER_USER_NAME          = data.azurerm_key_vault_secret.db_manager_username.value
      DB_MANAGER_PASSWORD           = data.azurerm_key_vault_secret.db_manager_password.value
      TENANT_ID                     = data.azurerm_client_config.current.tenant_id
    }
  }
  # depends_on = [
  #   azurerm_mssql_server.azuread_administrator
  # ]

  # only run if component or name override is set
  # due to legacy reasons people put var.product and var.component in product
  # but we only want the product so introduced a new field which allowed teams to move over to this format
  count = (var.component != "" || var.name != "") ? 1 : 0
}
