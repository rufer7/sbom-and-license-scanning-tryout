locals {
  database-name      = "dtrack"
  database-user-name = "dtrackdatabaseuser"
}

resource "random_password" "database-user-password" {
  length = 32
}

resource "azurerm_key_vault_secret" "database-user-password-secret" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "ALPINE-DATABASE-PASSWORD"
  value        = random_password.database-user-password.result
}

resource "azurerm_postgresql_flexible_server" "database-server" {
  name                          = replace(local.name_template, "<service>", "postgresql")
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = var.default_location
  tags                          = merge(var.service_tags, { description = "Azure Database for PostgreSQL" })
  administrator_login           = local.database-user-name
  administrator_password        = azurerm_key_vault_secret.database-user-password-secret.value
  sku_name                      = "B_Standard_B1ms"
  version                       = "16"
  storage_mb                    = 32768
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  auto_grow_enabled             = false
  public_network_access_enabled = true
  zone                          = "1"
}

resource "azurerm_postgresql_flexible_server_database" "dtrack-database" {
  name      = local.database-name
  server_id = azurerm_postgresql_flexible_server.database-server.id
  collation = "en_US.utf8"
  charset   = "utf8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

# The Azure feature 'Allow access to Azure services' can be enabled by setting 
# start_ip_address and end_ip_address to 0.0.0.0 which (is documented in the Azure API Docs).
# https://learn.microsoft.com/en-us/rest/api/sql/firewall-rules/create-or-update?view=rest-sql-2021-11-01&tabs=HTTP
resource "azurerm_postgresql_flexible_server_firewall_rule" "azure-services" {
  name             = "AzureServices"
  server_id        = azurerm_postgresql_flexible_server.database-server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
