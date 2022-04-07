# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.90"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "k8s0" {
    name     = var.resource_group_name
    location = var.location
}


resource "azurerm_kubernetes_cluster" "k8s0" {
    name                = var.cluster_name
    location            = azurerm_resource_group.k8s0.location
    resource_group_name = azurerm_resource_group.k8s0.name
    dns_prefix          = var.dns_prefix

    identity {
        type = "SystemAssigned"
    }

    linux_profile {
        admin_username = "ubuntu"

        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    default_node_pool {
        name            = "agentpool"
        node_count      = var.agent_count
        vm_size         = var.agent_vm
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "kubenet"
    }

    tags = {
        Environment = "realm"
    }


}