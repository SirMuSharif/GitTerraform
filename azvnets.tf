module "AzureHubVnetUS" {
  source                   = "./AzureVnets"
  VnetsResourceGroupNameUS = "Azure_Networking"
  VnetNameUS               = "Azure_HubVnet_US"
  Vnet_address_space_US    = ["10.11.0.0/16"]
  subnet_prefixes_US       = ["10.11.1.0/24" , "10.11.2.0/24" , "10.11.3.0/24"]
  subnet_names_US          = ["VPNGW_subnet", "AZFW_subnet" ,"BastionHost_subnet"]

}

module "AzureSpokeVnetUSERP" {
  source                   = "./AzureVnets"
  VnetsResourceGroupNameUS = "Azure_Networking"
  VnetNameUS               = "Azure_HubVnet_US"
  Vnet_address_space_US    = ["10.12.0.0/16"]
  subnet_prefixes_US       = ["10.12.1.0/24" , "10.12.2.0/24" , "10.12.3.0/24"]
  subnet_names_US          = ["ERPwebsubnet", "ERPbusinesssubnet", "ERPdbsubnet"]

}

module "AzureSpokeVnetUSPOS" {
  source                   = "./AzureVnets"
  VnetsResourceGroupNameUS = "Azure_Networking"
  VnetNameUS               = "Azure_HubVnet_US"
  Vnet_address_space_US    = ["10.13.0.0/16"]
  subnet_prefixes_US       = ["10.13.1.0/24" , "10.13.2.0/24" , "10.13.3.0/24"]
  subnet_names_US          = ["POSwebsubnet", "POSbusinesssubnet", "POSdbsubnet"]
}