
# Create virtual machine with public ip
resource "azurerm_linux_virtual_machine" "vm0" {
    name                  = "vm0"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    network_interface_ids = [azurerm_network_interface.nic0.id]
    size                  = "Standard_DS1_v2"


    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    admin_username = "larry"
    admin_ssh_key {
        username   = "larry"
        public_key = file("~/.ssh/realm_rsa.pub")
    }

}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm1" {
    name                  = "vm1"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    network_interface_ids = [azurerm_network_interface.nic1.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    admin_username = "larry"
    admin_ssh_key {
        username   = "larry"
        public_key = file("~/.ssh/realm_rsa.pub")
    }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm2" {
    name                  = "vm2"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    network_interface_ids = [azurerm_network_interface.nic2.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    admin_username = "larry"
    admin_ssh_key {
        username   = "larry"
        public_key = file("~/.ssh/realm_rsa.pub")
    }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm3" {
    name                  = "vm3"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    network_interface_ids = [azurerm_network_interface.nic3.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    admin_username = "larry"
    admin_ssh_key {
        username   = "larry"
        public_key = file("~/.ssh/realm_rsa.pub")
    }
}