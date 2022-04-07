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

resource "azurerm_resource_group" "rg1" {
  name     = "rau-testnet-rg1"
  location = "centralus"
}


resource "azurerm_virtual_network" "vnet0" {
  name                = "rau-testnet-vnet0"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "rau-testnet-vnet1"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "rau-testnet-vnet2"
  address_space       = ["10.3.0.0/16"]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

locals {
  peerings = [
    {
      vnetRGname = azurerm_resource_group.rg.name
      vnetName   = azurerm_virtual_network.vnet0.name
      vnetId     = azurerm_virtual_network.vnet0.id
    },
    {
      vnetRGname = azurerm_resource_group.rg1.name
      vnetName   = azurerm_virtual_network.vnet1.name
      vnetId     = azurerm_virtual_network.vnet1.id
    },
    {
      vnetRGname = azurerm_resource_group.rg1.name
      vnetName   = azurerm_virtual_network.vnet2.name
      vnetId     = azurerm_virtual_network.vnet2.id
    }
  ]
}

module "peermesh" {
  source = "../../realmModule/peermesh"
  federation = "raufed"
  # create a peer-mesh of following list
  peerings  = [
    {
      vnetName   = azurerm_virtual_network.vnet0.name
      vnetRGname = azurerm_virtual_network.vnet0.resource_group_name
      peerIds    = [
        azurerm_virtual_network.vnet1.id,
        azurerm_virtual_network.vnet2.id
      ]
    },
    {
      vnetName   = azurerm_virtual_network.vnet1.name
      vnetRGname = azurerm_virtual_network.vnet1.resource_group_name
      peerIds    = [
        azurerm_virtual_network.vnet0.id,
        azurerm_virtual_network.vnet2.id
      ]
    },
    {
      vnetName   = azurerm_virtual_network.vnet2.name
      vnetRGname = azurerm_virtual_network.vnet2.resource_group_name
      peerIds    = [
        azurerm_virtual_network.vnet0.id,
        azurerm_virtual_network.vnet1.id
      ]
    }
  ]
}
