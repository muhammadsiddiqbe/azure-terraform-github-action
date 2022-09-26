provider "azurerm" {
  features {}
}

resource "azurerm_servicebus_namespace" "primary" {
  name                = "${var.prefix}-sbnamespace"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_servicebus_namespace_authorization_rule" "primary" {
  name         = "${var.prefix}-sbnauth"
  namespace_id = azurerm_servicebus_namespace.primary.id
  send         = true
  listen       = true
  manage       = true
}

resource "azurerm_servicebus_topic" "primary" {
  name                = "${var.prefix}-sbtopic"
  namespace_id        = azurerm_servicebus_namespace.primary.id
  enable_partitioning = true
}

resource "azurerm_servicebus_subscription" "primary" {
  name               = "${var.prefix}-sbsubscription"
  topic_id           = azurerm_servicebus_topic.primary.id
  max_delivery_count = 1
}

resource "azurerm_servicebus_queue" "primary" {
  name                = "${var.prefix}-sbqueue"
  namespace_id        = azurerm_servicebus_namespace.primary.id
  enable_partitioning = true
}