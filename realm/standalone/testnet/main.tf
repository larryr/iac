# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.85"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rau-testnet-rg"
  location = "eastus2"
}

resource "azurerm_virtual_network" "vnet0" {
  name                = "rau-testnet-vnet0"
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "vnet0sub0" {
  name                 = "rau-testnet-vnet0sub0"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet0.name
  address_prefixes     = ["10.0.0.0/10"]

}

resource "azurerm_subnet" "vnet0sub1" {
  name                 = "rau-testnet-vnet0sub1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet0.name
  address_prefixes     = ["10.64.0.0/10"]

}

resource "azurerm_subnet" "vnet0sub2" {
  name                 = "rau-testnet-vnet0sub2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet0.name
  address_prefixes     = ["10.128.0.0/10"]

}

resource "azurerm_subnet" "vnet0sub3" {
  name                 = "rau-testnet-vnet0sub3"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet0.name
  address_prefixes     = ["10.192.0.0/10"]

}

