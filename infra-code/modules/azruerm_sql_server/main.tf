resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = "1.2"

  tags = lookup(each.value, "tags", {})
}

output "server_id" {
  value = azurerm_mssql_server.sql_server.id
}
/* SQL Server module not yet implemented in this scaffold.
	Implement `azurerm_mssql_server` resources here when needed.
*/
