output realmName {
    value  = local.realmName
}

output rg {
    description = "created realm resource group"
    value       = { 
                    name = azurerm_resource_group.rg.name, 
                    id = azurerm_resource_group.rg.id 
                    location = azurerm_resource_group.rg.location
                  }
}

output realmNet {
    description = "the network information of the realm"
    value       = {
        vnetId    = azurerm_virtual_network.vnet.id
        vnetName  = azurerm_virtual_network.vnet.name
        subnets   = tomap( {
          for subnet in azurerm_subnet.subnet :
            subnet.name => {
              id  = subnet.id
              cidr = subnet.address_prefixes
            }
        })
        rsrv_aks_svc_cidr = cidrsubnet(local.realmAddressSpace, 3, 0)
    }
}

