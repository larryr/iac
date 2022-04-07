
resource "azurerm_resource_group" "rg" {
  name     = local.realmRG
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.realmVnet        #var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  address_space       = [local.realmAddressSpace]
}

# setup standard subnets
resource "azurerm_subnet" "subnet" {
  for_each = local.realmSubnets

  name                 = "${local.realmName}.subnet-${each.key}"
  resource_group_name  = azurerm_resource_group.rg.name

  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(local.realmAddressSpace, 3, each.value)]
}
