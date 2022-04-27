resource "azurerm_resource_group" "g4s3" {
  name     = "g4s3-resources"
  location = "westus"
}

resource "azurerm_virtual_network" "g4s3" {
  name                = "g4s3-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.g4s3.location
  resource_group_name = azurerm_resource_group.g4s3.name
}

resource "azurerm_subnet" "g4s3" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.g4s3.name
  virtual_network_name = azurerm_virtual_network.g4s3.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "g4s3" {
  name                = "g4s3-nic"
  location            = azurerm_resource_group.g4s3.location
  resource_group_name = azurerm_resource_group.g4s3.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.g4s3.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "g4s3" {
  name                = "g4s3-machine"
  resource_group_name = azurerm_resource_group.g4s3.name
  location            = azurerm_resource_group.g4s3.location
  size                = "Standard_D2_v2"
  admin_username      = "devops"
  network_interface_ids = [
    azurerm_network_interface.g4s3.id,
  ]

  admin_ssh_key {
    username   = "devops"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}