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

variable federation {
  default = "raufed-0"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.federation}-rg"
  location = "eastus2"
}


module "realm0" {
  source = "./realmModule/az/realmnet"

  fedName      = var.federation
  realmID      = 0
  location     = "eastus2"
}

module "realm1" {
  source = "./realmModule/az/realmnet"

  fedName      = var.federation
  realmID      = 1
  location     = "centralus"
}
/*
module "realm2" {
  source = "./realmModule/az/realmnet"

  fedName      = var.federation
  realmID      = 2
  location     = "westus2"
}
*/

module "k8s0" {
  source = "./realmModule/az/k8s"
  realmName  = module.realm0.realmName
  rgName     = module.realm0.rg.name
  location   = module.realm0.rg.location
  nodecount  = 12
  sshpub     = "/Users/larry/.ssh/realm_rsa.pub"
  realmNet   = module.realm0.realmNet
  registry   = {name="rauregistry", rgName="rauglobal"}
}

module "k8s1" {
  source = "./realmModule/az/k8s"
  realmName  = module.realm1.realmName
  rgName     = module.realm1.rg.name
  location   = module.realm1.rg.location
  nodecount  = 3
  sshpub     = "/Users/larry/.ssh/realm_rsa.pub"
  realmNet   = module.realm1.realmNet
  registry   = {name="rauregistry", rgName="rauglobal"}
}

/*
module "k8s2" {
  source = "./realmModule/az/k8s"
  realmName  = module.realm2.realmName
  rgName     = module.realm2.rg.name
  location   = module.realm2.rg.location
  nodecount  = 3
  sshpub     = "/Users/larry/.ssh/realm_rsa.pub"
  vnet_id             = module.realm2.vnet_id
  nodes_subnet_id     = module.realm2.subnet_ids["${module.realm2.realmName}.subnet-nodes"]
  pods_subnet_id      = module.realm2.subnet_ids["${module.realm2.realmName}.subnet-pods"]
  rsrv_aks_svc_cidr   = module.realm2.rsrv_aks_svc_cidr
}
*/

module "jumpsrv" {
  source    = "./realmModule/az/jumpsrv"
  rgName    = module.realm0.rg.name
  location  = module.realm0.rg.location
  sshpub    = "/Users/larry/.ssh/realm_rsa.pub"
  vnet_id   = module.realm0.realmNet.vnetId
  subnet_id = module.realm0.realmNet.subnets["${module.realm0.realmName}.subnet-srv"].id
  dns_zone_name = "realm"
}



# setup a mesh among all realms
module "peermesh" {
  source = "./realmModule/az/peermesh"
  federation = var.federation
  # create a peer-mesh of following list
  peerings = [
    {
      vnetRGname = module.realm0.rg.name
      vnetName   = module.realm0.realmNet.vnetName
      peerIds    = [
        module.realm1.realmNet.vnetId
      ]
    },
    {
      vnetRGname = module.realm1.rg.name
      vnetName   = module.realm1.realmNet.vnetName
      peerIds    = [
        module.realm0.realmNet.vnetId
      ]
    }
  ]
}
