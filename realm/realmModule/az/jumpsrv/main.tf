resource "azurerm_public_ip" "pip" {
  name                = "jump-pip"
  location            = var.location
  resource_group_name = var.rgName
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "jump_sg" {
  name                = "rau-jump-sg"
  location            = var.location
  resource_group_name = var.rgName

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "jump_nic" {
  name                = "jump-nic"
  location            = var.location
  resource_group_name = var.rgName

  ip_configuration {
    name                          = "jump-niccfg"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "sg_association" {
  network_interface_id      = azurerm_network_interface.jump_nic.id
  network_security_group_id = azurerm_network_security_group.jump_sg.id
}

## note: change to a pre-created image.

resource "azurerm_linux_virtual_machine" "jumpsrv" {
  name                            = "jumpvm"
  location                        = var.location
  resource_group_name             = var.rgName
  network_interface_ids           = [azurerm_network_interface.jump_nic.id]
  size                            = "Standard_DS1_v2"
  computer_name                   = "jumpsrv"
  admin_username                  = "larry"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "larry"
    public_key = file(var.sshpub)
  }

  os_disk {
    name                 = "jumpOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

}
/*
resource "azurerm_private_dns_zone_virtual_network_link" "hublink" {
  name                  = "hubnetdnsconfig"
  resource_group_name   = var.rgName
  private_dns_zone_name = var.dns_zone_name
  virtual_network_id    = var.vnet_id
}
*/