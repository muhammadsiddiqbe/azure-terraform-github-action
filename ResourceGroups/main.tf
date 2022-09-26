terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_resource_group" "secondary" {
  name     = "secondary_rg"
  location = var.resource_group_location

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_resource_group" "tertiary" {
  name     = "secondary_rg"
  location = var.resource_group_location

  tags = {
    Environment = var.environment
  }
}