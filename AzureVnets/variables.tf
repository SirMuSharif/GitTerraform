variable "VnetsResourceGroupNameUS" {
  description = "Name of the vnet to create."
  type = string
}

variable "VnetNameUS" {
  description = "The name of an existing resource group to be imported."
  type = string
}

variable "Vnet_address_space_US" {
  description = "The address space that is used by the virtual network."
  type        = list(string)
}


variable "subnet_names_US" {
  description = "A list of subnets inside the vNet."
  type        = list(string)
  
}

variable "subnet_prefixes_US" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
 
}

