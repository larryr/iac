# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.94"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rauglobal"
  location = "eastus2"
}

resource "azurerm_container_registry" "acr" {
  name                     = "rauregistry"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  sku                      = "Premium"
  admin_enabled            = false
  #tags
  #georeplication_locations
  #network_rule_set {}
}
