# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azuread_client_config" "current" {}

output "object_id" {
  value = data.azuread_client_config.current.object_id
}

######

module "ResourceGroup" {
  source = "./ResourceGroup"

  resource_group_name = "MainRG"
  resource_group_location = "eastus"
  environment = var.environment
}

module "StorageAccount" {
  source = "./StorageAccount"
  base_name = "mypro"
  resource_group_name = module.ResourceGroup.rg_name_out
  location = var.location
}