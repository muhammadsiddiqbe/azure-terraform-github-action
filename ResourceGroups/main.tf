terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-con-nest-env${var.environment}-${var.location}-01"
  location = var.location

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_resource_group" "service_bus" {
  name     = "rg-servicebus-nest-${var.environment}-${var.location}-01"
  location = var.location

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_resource_group" "rg_bastion" {
  name     = "rg-aba-nest-${var.environment}-${var.location}-01"
  location = var.location

  tags = {
    Environment = var.environment
  }
}