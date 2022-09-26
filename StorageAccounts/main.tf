terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

resource "azurerm_storage_account" "primary" {
  name                     = "${lower(var.base_name)}${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"


  network_rules {
    bypass         = ["AzureServices", "Logging", "Metrics"]
    default_action = "Allow"
  }
}

resource "azurerm_storage_account" "secondary" {
  name                     = "ssecondary${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"


  network_rules {
    bypass         = ["AzureServices", "Logging", "Metrics"]
    default_action = "Allow"
  }
}

resource "azurerm_storage_queue" "storage_queue" {
  name                 = "${random_string.random.result}queue"
  storage_account_name = azurerm_storage_account.primary.name
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "${random_string.random.result}vhds"
  storage_account_name  = azurerm_storage_account.primary.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storage_blob" {
  name = "herpderp1.vhd"

  storage_account_name   = azurerm_storage_account.primary.name
  storage_container_name = azurerm_storage_container.storage_container.name

  type = "Page"
  size = 5120
}