#This file contains output values those give information about the current insfracture available on the command line.
#They also give informations for other terraform configurations to use.
output "host_name" {
  value = "${azurerm_mssql_server.mssql-paas.name}.mssql.database.azure.com"
}

output "mssql_listen_port" {
  value = var.mssql_listen_port
}

output "mssql_database" {
  value = azurerm_mssql_database.mssql-db.name
}

output "mssql_password" {
  value = random_password.password.result
  sensitive = true
}

output "user_name" {
  value = "${var.mssql_user}@${azurerm_mssql_server.mssql-paas.name}"
}

output "name" {
  value = azurerm_mssql_server.mssql-paas.name
}

output "resource_group_name" {
  value = azurerm_mssql_server.mssql-paas.resource_group_name
}

output "id" {
  value = azurerm_mssql_server.mssql-paas.id
}
