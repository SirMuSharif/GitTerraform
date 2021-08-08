resource "tls_private_key" "example_ssh3" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "azurerm_linux_virtual_machine" "MnlkVM" {
  name                  = "MnlkVM"
  location              = "eastus"
  resource_group_name   = azurerm_resource_group.example3.name
  network_interface_ids = [azurerm_network_interface.MnlkVM.id]
  size                  = "Standard_B1S"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh3.public_key_openssh
  }



  tags = {
    environment = "Terraform Demo"
  }
}


resource "azurerm_network_interface" "MnlkVM" {
  name                = "myNIC-MnlkVM"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example3.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example3.id
  }

  tags = {
    environment = "Terraform Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example3" {
  network_interface_id      = azurerm_network_interface.MnlkVM.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_public_ip" "example3" {
  name                = "myPublicIP-MnlkVM"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example3.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Demo"
  }
}



resource "tls_private_key" "example_sshexampleMnlk1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "azurerm_linux_virtual_machine" "MnlkVM1" {
  name                  = "MnlkVM1"
  location              = var.location0
  resource_group_name   = azurerm_resource_group.example3.name
  network_interface_ids = [azurerm_network_interface.MnlkVM1.id]
  size                  = "Standard_B1S"

  os_disk {
    name                 = "myOsDisk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "MnlkVM1"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh3.public_key_openssh
  }



  tags = {
    environment = "Terraform MnlkVM1 Demo"
  }
}


resource "azurerm_network_interface" "MnlkVM1" {
  name                = "myNIC-MnlkVM1"
  location            = var.location0
  resource_group_name = azurerm_resource_group.example3.name

  ip_configuration {
    name                          = "myNicConfigurationMnlkVM1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.exampleMnlk1.id
  }

  tags = {
    environment = "Terraform MnlkVM1 Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "exampleexampleMnlk1" {
  network_interface_id      = azurerm_network_interface.MnlkVM1.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_public_ip" "exampleMnlk1" {
  name                = "myPublicIP-Mnlk1"
  location            = var.location0
  resource_group_name = azurerm_resource_group.example3.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Mnlk1 Demo"
  }
}




resource "azurerm_linux_virtual_machine" "MnlkVM2" {
  name                  = "MnlkVM2"
  location              = var.location0
  resource_group_name   = azurerm_resource_group.example3.name
  network_interface_ids = [azurerm_network_interface.MnlkVM2.id]
  size                  = "Standard_B1S"

  os_disk {
    name                 = "myOsDisk2MnlkVM2"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "MnlkVM2"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh3.public_key_openssh
  }



  tags = {
    environment = "Terraform MnlkVM2 Demo"
  }
}


resource "azurerm_network_interface" "MnlkVM2" {
  name                = "myNIC-MnlkVM2"
  location            = var.location0
  resource_group_name = azurerm_resource_group.example3.name

  ip_configuration {
    name                          = "myNicConfigurationMnlkVM2"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.exampleMnlkVM2.id
  }

  tags = {
    environment = "Terraform MnlkVM2 Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "exampleexampleMnlkVM2" {
  network_interface_id      = azurerm_network_interface.MnlkVM2.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_public_ip" "exampleMnlkVM2" {
  name                = "myPublicIP-MnlkVM2"
  location            = var.location0
  resource_group_name = azurerm_resource_group.example3.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform MnlkVMWind Demo"
  }
}


resource "azurerm_windows_virtual_machine" "MnlkVMWind" {
  name                  = "MnlkVMWind"
  location              = var.location
  resource_group_name   = azurerm_resource_group.example2.name
  network_interface_ids = [azurerm_network_interface.MnlkVMWind1.id]
  size                  = "Standard_B1S"

  os_disk {
    name                 = "myOsDiskMnlkVMWind"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  computer_name  = "MnlkVMWind"
  admin_username = "adminuser"
  admin_password = "P@$$w0rd1234!"






  tags = {
    environment = "Terraform MnlkVMWind Demo"
  }
}


resource "azurerm_network_interface" "MnlkVMWind1" {
  name                = "myNIC-MnlkVMWind1"
  location            = var.location
  resource_group_name = azurerm_resource_group.example2.name

  ip_configuration {
    name                          = "myNicConfigurationMnlkVMWind11"
    subnet_id                     = azurerm_subnet.exampleVMSS1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.exampleMnlkVMWind.id
  }

  tags = {
    environment = "Terraform MnlkVMWind Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "exampleexampleMnlkVMWind" {
  network_interface_id      = azurerm_network_interface.MnlkVMWind1.id
  network_security_group_id = azurerm_network_security_group.exampleVMSS.id
}

resource "azurerm_public_ip" "exampleMnlkVMWind" {
  name                = "myPublicIP-MnlkVMWind"
  location            = var.location
  resource_group_name = azurerm_resource_group.example2.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform MnlkVMWind Demo"
  }
}