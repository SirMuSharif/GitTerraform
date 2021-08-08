#provider "azurerm" {
#  features {}
#}

module "MdSchoolContainer" {
  source                     = "./AzureStorage"
  StorageResourceGroupNameUS = "Sch_Marketing_Contents"
  StorageAccountNameUS       = "mdschoolphoto22"
  ContainerNameUS            = "mdphotos"
}

module "PmSchoolContainer" {
  source                     = "./AzureStorage"
  StorageResourceGroupNameUS = "Sch_Marketing_Contents"
  StorageAccountNameUS       = "pmschoolphoto22"
  ContainerNameUS            = "pmphotos"
}