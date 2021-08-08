resource "azurerm_resource_group" "azschvnetstemplet" {
  name     = var.VnetsResourceGroupNameUS
  location = "East US"
}

resource "azurerm_virtual_network" "azschvnetstemplet" {
  name                = var.VnetNameUS
  location            = azurerm_resource_group.azschvnetstemplet.location
  resource_group_name = azurerm_resource_group.azschvnetstemplet.name
  address_space       = var.Vnet_address_space_US
  #["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5", "10.0.1.5", "10.0.1.5", "10.0.2.5", "10.0.2.5"]


 /* subnet {
    name           = var.subnet_names_US
    address_prefix = var.subnet_prefixes_US
#    security_group = azurerm_network_security_group.azschvnetstemplet.id
  } */

  tags = {
    environment = "Production"
  }
}