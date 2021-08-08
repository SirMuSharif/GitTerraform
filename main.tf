#terraform {
#  backend "local" {
#    path = "C:\Users\Mustafa.mohamed\Terraform\terraform.tfstate"
#  }
# }

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "Action-1-resources"
  location = "eastus"
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceActionSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_network_security_rule" "example" {
  name                        = "SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_network_security_rule" "example1" {
  name                        = "Https"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_network_security_rule" "example2" {
  name                        = "DNS"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}
resource "azurerm_network_security_rule" "example3" {
  name                        = "DNS-UDP"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_network_security_rule" "example4" {
  name                        = "Http"
  priority                    = 104
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_network_security_rule" "example5" {
  name                        = "Nginx"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "Action-1-virtualNetwork1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5", "10.0.1.5", "10.0.1.5", "10.0.2.5", "10.0.2.5"]

  tags = {
    environment = "ActionProduction1"
  }
}


resource "azurerm_subnet" "example" {
  name                 = "Webtire"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "example1" {
  name                 = "Biztier"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "example2" {
  name                 = "DBtier"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
}


resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}


resource "azurerm_subnet_network_security_group_association" "example1" {
  subnet_id                 = azurerm_subnet.example1.id
  network_security_group_id = azurerm_network_security_group.example1.id
}

resource "azurerm_network_interface" "example" {
  name                = "myNIC"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }

  tags = {
    environment = "Terraform Demo"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_public_ip" "example" {
  name                = "myPublicIP"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"

  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "actionstorage1"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "example" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}



resource "azurerm_resource_group" "example1" {
  name     = "Microservices-rg"
  location = var.location
  tags = {
    env = "Microservices-demo"
  }
}

resource "azurerm_resource_group" "example2" {
  name     = "SOA-rg"
  location = var.location
  tags = {
    env = "SOA-demo"
  }
}

resource "azurerm_resource_group" "example3" {
  name     = "Monolithic-rg"
  location = var.location
  tags = {
    env = "Monolithic-demo"
  }
}


resource "azurerm_network_security_group" "example1" {
  name                = "acceptanceActionSecurityGroupScaleSet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_network_security_rule" "exampleScSet1" {
  name                        = "SSHScSet1"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example1.name
}


resource "azurerm_virtual_network" "exampleAKS" {
  name                = "Action-2-virtualNetworkAKS"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.2.0.0/16"]
  dns_servers         = ["10.2.0.4", "10.2.0.5", "10.2.1.5", "10.2.1.5", "10.2.2.5", "10.2.2.5"]

  tags = {
    environment = "ActionProductionAKS"
  }
}


resource "azurerm_subnet" "exampleAKS2" {
  name                 = "Webtire2"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleAKS.name
  address_prefixes     = ["10.2.2.0/24"]
}

resource "azurerm_subnet" "exampleAKS1" {
  name                 = "Biztier2"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleAKS.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_subnet" "exampleAKS0" {
  name                 = "DBtier2"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleAKS.name
  address_prefixes     = ["10.2.0.0/24"]
}


resource "azurerm_network_security_group" "exampleAKS" {
  name                = "acceptanceActionSecurityGroupAKS"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "exampleAKS1" {
  name                        = "SSHAKS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleAKS.name
}

resource "azurerm_network_security_rule" "exampleAKS2" {
  name                        = "HttpsAKS"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleAKS.name
}

resource "azurerm_network_security_rule" "exampleAKS3" {
  name                        = "DNSAKS"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleAKS.name
}
resource "azurerm_network_security_rule" "exampleAKS4" {
  name                        = "DNS-UDPAKS"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleAKS.name
}

resource "azurerm_network_security_rule" "exampleAKS5" {
  name                        = "HttpAKS"
  priority                    = 104
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleAKS.name
}

resource "azurerm_network_security_rule" "exampleAKS7" {
  name                        = "NginxAKS"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleAKS.name
}

resource "azurerm_subnet_network_security_group_association" "exampleAKS" {
  subnet_id                 = azurerm_subnet.exampleAKS2.id
  network_security_group_id = azurerm_network_security_group.exampleAKS.id
}





resource "azurerm_virtual_network" "example2" {
  name                = "Action-2-virtualNetwork2"
  location            = var.location
  resource_group_name = azurerm_resource_group.example1.name
  address_space       = ["10.1.0.0/16"]
  dns_servers         = ["10.1.0.4", "10.1.0.5", "10.1.1.5", "10.1.1.5", "10.1.2.5", "10.1.2.5"]

  tags = {
    environment = "ActionProduction2"
  }
}


resource "azurerm_subnet" "exampleVMSS1" {
  name                 = "Webtire1"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "exampleVMSS2" {
  name                 = "Biztier1"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "exampleVMSS0" {
  name                 = "DBtier1"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.1.0.0/24"]
}


resource "azurerm_network_security_group" "exampleVMSS" {
  name                = "acceptanceActionSecurityGroupVMSS"
  location            = var.location
  resource_group_name = azurerm_resource_group.example1.name
}

resource "azurerm_network_security_rule" "exampleVMSS1" {
  name                        = "SSHVMSS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example1.name
  network_security_group_name = azurerm_network_security_group.exampleVMSS.name
}

resource "azurerm_network_security_rule" "exampleVMSS2" {
  name                        = "HttpsVMSS"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example1.name
  network_security_group_name = azurerm_network_security_group.exampleVMSS.name
}

resource "azurerm_network_security_rule" "exampleVMSS3" {
  name                        = "DNSVMSS"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example1.name
  network_security_group_name = azurerm_network_security_group.exampleVMSS.name
}
resource "azurerm_network_security_rule" "exampleVMSS4" {
  name                        = "DNS-UDPVMSS"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example1.name
  network_security_group_name = azurerm_network_security_group.exampleVMSS.name
}

resource "azurerm_network_security_rule" "exampleVMSS5" {
  name                        = "HttpVMSS"
  priority                    = 104
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example1.name
  network_security_group_name = azurerm_network_security_group.exampleVMSS.name
}

resource "azurerm_network_security_rule" "exampleVMSS7" {
  name                        = "NginxVMSS"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example1.name
  network_security_group_name = azurerm_network_security_group.exampleVMSS.name
}

resource "azurerm_subnet_network_security_group_association" "exampleVMSS" {
  subnet_id                 = azurerm_subnet.exampleVMSS1.id
  network_security_group_id = azurerm_network_security_group.exampleVMSS.id
}

resource "azurerm_virtual_network" "exampledkr" {
  name                = "Action-2-virtualNetworkdkr"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.3.0.0/16"]
  dns_servers         = ["10.3.0.4", "10.3.0.5", "10.3.1.5", "10.3.1.5", "10.3.2.5", "10.3.2.5"]

  tags = {
    environment = "ActionProductiondkr"
  }
}


resource "azurerm_subnet" "exampledkr1" {
  name                 = "Webtiredkr1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampledkr.name
  address_prefixes     = ["10.3.2.0/24"]
}

resource "azurerm_subnet" "exampledkr2" {
  name                 = "Biztierdkr1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampledkr.name
  address_prefixes     = ["10.3.1.0/24"]
}

resource "azurerm_subnet" "exampledkr3" {
  name                 = "DBtierdkr1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampledkr.name
  address_prefixes     = ["10.3.0.0/24"]
}


resource "azurerm_network_security_group" "exampledkr" {
  name                = "acceptanceActionSecurityGroupdkr"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "exampledkr1" {
  name                        = "SSHdkr"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampledkr.name
}

resource "azurerm_network_security_rule" "exampledkr2" {
  name                        = "Httpsdkr"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampledkr.name
}

resource "azurerm_network_security_rule" "exampledkr3" {
  name                        = "DNSdkr"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampledkr.name
}
resource "azurerm_network_security_rule" "exampledkr4" {
  name                        = "DNS-UDPdkr"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampledkr.name
}

resource "azurerm_network_security_rule" "exampledkr5" {
  name                        = "Httpdkr"
  priority                    = 104
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampledkr.name
}

resource "azurerm_network_security_rule" "exampledkr7" {
  name                        = "Nginxdkr"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampledkr.name
}

resource "azurerm_subnet_network_security_group_association" "exampledkr" {
  subnet_id                 = azurerm_subnet.exampledkr1.id
  network_security_group_id = azurerm_network_security_group.exampledkr.id
}




resource "azurerm_virtual_network" "examplefas" {
  name                = "Action-2-virtualNetworkfas"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.4.0.0/16"]
  dns_servers         = ["10.4.0.4", "10.4.0.5", "10.4.1.5", "10.4.1.5", "10.4.2.5", "10.4.2.5"]

  tags = {
    environment = "ActionProductionfas"
  }
}


resource "azurerm_subnet" "examplefas1" {
  name                 = "Webtirefas1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.examplefas.name
  address_prefixes     = ["10.4.2.0/24"]
}

resource "azurerm_subnet" "examplefas2" {
  name                 = "Biztierfas1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.examplefas.name
  address_prefixes     = ["10.4.1.0/24"]
}

resource "azurerm_subnet" "examplefas3" {
  name                 = "DBtierfas1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.examplefas.name
  address_prefixes     = ["10.4.0.0/24"]
}


resource "azurerm_network_security_group" "examplefas" {
  name                = "acceptanceActionSecurityGroupfas"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "examplefas1" {
  name                        = "SSHfas"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplefas.name
}

resource "azurerm_network_security_rule" "examplefas2" {
  name                        = "Httpsfas"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplefas.name
}

resource "azurerm_network_security_rule" "examplefas3" {
  name                        = "DNSfas"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplefas.name
}
resource "azurerm_network_security_rule" "examplefas4" {
  name                        = "DNS-UDPfas"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplefas.name
}

resource "azurerm_network_security_rule" "examplefas5" {
  name                        = "Httpfas"
  priority                    = 104
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplefas.name
}

resource "azurerm_network_security_rule" "examplefas7" {
  name                        = "Nginxfas"
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplefas.name
}

resource "azurerm_subnet_network_security_group_association" "examplefas" {
  subnet_id                 = azurerm_subnet.examplefas1.id
  network_security_group_id = azurerm_network_security_group.examplefas.id
}


resource "azurerm_virtual_network" "exampleauto" {
  name                = "Action-2-virtualNetworkauto"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.5.0.0/16"]
  dns_servers         = ["10.5.0.4", "10.5.0.5", "10.5.1.5", "10.5.1.5", "10.5.2.5", "10.5.2.5"]

  tags = {
    environment = "ActionProductionauto"
  }
}


resource "azurerm_subnet" "exampleauto1" {
  name                 = "Webtireauto1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleauto.name
  address_prefixes     = ["10.5.2.0/24"]
}

resource "azurerm_subnet" "exampleauto2" {
  name                 = "Biztierauto1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleauto.name
  address_prefixes     = ["10.5.1.0/24"]
}

resource "azurerm_subnet" "exampleauto3" {
  name                 = "DBtierauto1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleauto.name
  address_prefixes     = ["10.5.0.0/24"]
}


resource "azurerm_network_security_group" "exampleauto" {
  name                = "acceptanceActionSecurityGroupauto"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "exampleauto1" {
  name                        = "SSHauto"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleauto.name
}

resource "azurerm_network_security_rule" "exampleauto2" {
  name                        = "Httpsauto"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleauto.name
}

resource "azurerm_network_security_rule" "exampleauto3" {
  name                        = "DNSauto"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleauto.name
}
resource "azurerm_network_security_rule" "exampleauto4" {
  name                        = "DNS-UDPauto"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleauto.name
}



resource "azurerm_subnet_network_security_group_association" "exampleauto" {
  subnet_id                 = azurerm_subnet.exampleauto1.id
  network_security_group_id = azurerm_network_security_group.exampleauto.id
}



resource "azurerm_virtual_network" "exampleSOC" {
  name                = "Action-2-virtualNetworkSOC"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.10.0.0/16"]
  dns_servers         = ["10.10.0.4", "10.10.0.5", "10.10.0.5", "10.5.1.5", "10.10.2.5", "10.10.2.5"]

  tags = {
    environment = "ActionProductionSOC"
  }
}


resource "azurerm_subnet" "exampleSOC1" {
  name                 = "WebtireSOC1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleSOC.name
  address_prefixes     = ["10.10.2.0/24"]
}

resource "azurerm_subnet" "exampleSOC2" {
  name                 = "BiztierSOC1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleSOC.name
  address_prefixes     = ["10.10.1.0/24"]
}




resource "azurerm_network_security_group" "exampleSOC" {
  name                = "acceptanceActionSecurityGroupSOC"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "exampleSOC1" {
  name                        = "SSHSOC"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSOC.name
}

resource "azurerm_network_security_rule" "exampleSOC2" {
  name                        = "HttpsSOC"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSOC.name
}

resource "azurerm_network_security_rule" "exampleSOC3" {
  name                        = "DNSSOC"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSOC.name
}
resource "azurerm_network_security_rule" "exampleSOC4" {
  name                        = "DNS-UDPSOC"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSOC.name
}



resource "azurerm_subnet_network_security_group_association" "exampleSOC" {
  subnet_id                 = azurerm_subnet.exampleSOC1.id
  network_security_group_id = azurerm_network_security_group.exampleSOC.id
}



resource "azurerm_virtual_network" "exampleSRE" {
  name                = "Action-2-virtualNetworkSRE"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.9.0.0/16"]
  dns_servers         = ["10.9.0.4", "10.9.0.5", "10.9.0.5", "10.9.1.5", "10.9.2.5", "10.9.2.5"]

  tags = {
    environment = "ActionProductionSOC"
  }
}


resource "azurerm_subnet" "exampleSRE1" {
  name                 = "WebtireSRE1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleSRE.name
  address_prefixes     = ["10.9.2.0/24"]
}

resource "azurerm_subnet" "exampleSRE2" {
  name                 = "BiztierSRE1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleSRE.name
  address_prefixes     = ["10.9.1.0/24"]
}




resource "azurerm_network_security_group" "exampleSRE" {
  name                = "acceptanceActionSecurityGroupSRE"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "exampleSRE1" {
  name                        = "SSHSRE"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSRE.name
}

resource "azurerm_network_security_rule" "exampleSRE2" {
  name                        = "HttpsSRE"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSRE.name
}

resource "azurerm_network_security_rule" "exampleSRE3" {
  name                        = "DNSSRE"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSRE.name
}
resource "azurerm_network_security_rule" "exampleSRE4" {
  name                        = "DNS-UDPSRE"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleSRE.name
}



resource "azurerm_subnet_network_security_group_association" "exampleSRE" {
  subnet_id                 = azurerm_subnet.exampleSRE1.id
  network_security_group_id = azurerm_network_security_group.exampleSRE.id
}




resource "azurerm_virtual_network" "examplePAAS" {
  name                = "Action-2-virtualNetworkPAAS"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.8.0.0/16"]
  dns_servers         = ["10.8.0.4", "10.8.0.5", "10.8.0.5", "10.8.1.5", "10.8.2.5", "10.8.2.5"]

  tags = {
    environment = "ActionProductionPAAS"
  }
}


resource "azurerm_subnet" "examplePAAS1" {
  name                 = "WebtirePAAS1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.examplePAAS.name
  address_prefixes     = ["10.8.2.0/24"]
}

resource "azurerm_subnet" "examplePAAS2" {
  name                 = "BiztierPAAS1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.examplePAAS.name
  address_prefixes     = ["10.8.1.0/24"]
}




resource "azurerm_network_security_group" "examplePAAS" {
  name                = "acceptanceActionSecurityGroupPAAS"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "examplePAAS1" {
  name                        = "SSHPAAS"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplePAAS.name
}

resource "azurerm_network_security_rule" "examplePAAS2" {
  name                        = "HttpsPAAS"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplePAAS.name
}

resource "azurerm_network_security_rule" "examplePAAS3" {
  name                        = "DNSPAAS"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplePAAS.name
}
resource "azurerm_network_security_rule" "examplePAAS4" {
  name                        = "DNS-UDPPAAS"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.examplePAAS.name
}



resource "azurerm_subnet_network_security_group_association" "examplePAAS" {
  subnet_id                 = azurerm_subnet.examplePAAS1.id
  network_security_group_id = azurerm_network_security_group.examplePAAS.id
}

resource "azurerm_virtual_network" "exampleERP" {
  name                = "Action-2-virtualNetworkERP"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
  address_space       = ["10.7.0.0/16"]
  dns_servers         = ["10.7.0.4", "10.7.0.5", "10.7.0.5", "10.7.1.5", "10.7.2.5", "10.7.2.5"]

  tags = {
    environment = "ActionProductionERP"
  }
}


resource "azurerm_subnet" "exampleERP1" {
  name                 = "WebtireERP1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleERP.name
  address_prefixes     = ["10.7.2.0/24"]
}

resource "azurerm_subnet" "exampleERP2" {
  name                 = "BiztierERP1"
  resource_group_name  = azurerm_resource_group.example2.name
  virtual_network_name = azurerm_virtual_network.exampleERP.name
  address_prefixes     = ["10.7.1.0/24"]
}




resource "azurerm_network_security_group" "exampleERP" {
  name                = "acceptanceActionSecurityGroupERP"
  location            = var.location1
  resource_group_name = azurerm_resource_group.example2.name
}

resource "azurerm_network_security_rule" "exampleERP1" {
  name                        = "SSHERP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleERP.name
}

resource "azurerm_network_security_rule" "exampleERP2" {
  name                        = "HttpsERP"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleERP.name
}

resource "azurerm_network_security_rule" "exampleERP3" {
  name                        = "DNSERP"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleERP.name
}
resource "azurerm_network_security_rule" "exampleERP4" {
  name                        = "DNS-UDPERP"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "UDP"
  source_port_range           = "*"
  destination_port_range      = "53"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example2.name
  network_security_group_name = azurerm_network_security_group.exampleERP.name
}



resource "azurerm_subnet_network_security_group_association" "exampleERP" {
  subnet_id                 = azurerm_subnet.exampleERP1.id
  network_security_group_id = azurerm_network_security_group.exampleERP.id
}