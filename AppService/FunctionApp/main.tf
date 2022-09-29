provider "azurerm" {
  features {}
}

resource "azurerm_service_plan" "primary" {
  name                = "${var.prefix}-sp"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_function_app" "primary" {
  name                = "main-func-app"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  service_plan_id = azurerm_service_plan.primary.id

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {}
}

resource "azurerm_linux_function_app" "function_app" {
  name                = "secondary-func-app"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  service_plan_id = azurerm_service_plan.primary.id

  # app_settings = {
  #   "WEBSITE_RUN_FROM_PACKAGE"       = "",
  #   "FUNCTIONS_WORKER_RUNTIME"       = "node",
  #   "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.application_insights.instrumentation_key,
  # }

  site_config {

  }

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }

  # connection_string {
  #   name  = azurerm_postgresql_database.postgressql_db.name
  #   type  = "SQLServer"
  #   value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  # }
}

resource "azurerm_application_insights" "logging" {
  name                = "${var.prefix}-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  retention_in_days   = 90
  tags = {
    sample = "azure-functions-event-grid-terraform"
  }
}