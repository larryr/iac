# Create network interface with a public IP as well as internal

resource "azurerm_public_ip" "pip" {
  name                = "pip0"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

output "pip-ip" {
    value = azurerm_public_ip.pip.ip_address
}
output "pip-fqdn" {
    value = azurerm_public_ip.pip.fqdn
}

resource "azurerm_network_interface" "nic0" {
    name                      = "nic0"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
    ip_configuration {
        name                          = "nic0cfg"
        subnet_id                     = azurerm_subnet.vnet0sub0.id
        private_ip_address_allocation = "static"
        private_ip_address            = "10.32.0.0"
        public_ip_address_id          = azurerm_public_ip.pip.id
    }
}

# Create network interface
resource "azurerm_network_interface" "nic1" {
    name                      = "nic1"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
    ip_configuration {
        name                          = "nic1cfg"
        subnet_id                     = azurerm_subnet.vnet0sub1.id
        private_ip_address_allocation = "static"
        private_ip_address            = "10.96.0.0"
    }
}

# Create network interface
resource "azurerm_network_interface" "nic2" {
    name                      = "nic2"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
    ip_configuration {
        name                          = "nic2cfg"
        subnet_id                     = azurerm_subnet.vnet0sub2.id
        private_ip_address_allocation = "static"
        private_ip_address            = "10.160.0.0"
    }
}


# Create network interface
resource "azurerm_network_interface" "nic3" {
    name                      = "nic3"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
    ip_configuration {
        name                          = "nic3cfg"
        subnet_id                     = azurerm_subnet.vnet0sub3.id
        private_ip_address_allocation = "static"
        private_ip_address            = "10.224.0.0"
    }
}