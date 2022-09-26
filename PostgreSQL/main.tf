resource "azurerm_postgresql_server" "main-psql" {
  name                = var.postgresql_server_primary_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  administrator_login          = var.psql_admin_login
  administrator_login_password = var.psql_admin_password

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "postgressql_db" {
  name                = var.Postgresql_DB
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_server.main-psql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}