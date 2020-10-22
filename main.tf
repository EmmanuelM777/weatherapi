# Terrafom Infrastructure as code definition

# variables
variable "imagebuild" {
  type        = string
  description = "build number"
}

# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version             = "2.5.0"
  subscription_id     = "e8a813aa-c853-4740-aefd-16d60c38dbf7"
  features {}
}

# Define where in azure terraform should keep terraform.tfstate  
terraform {
  backend "azurerm" {
    subscription_id     = "e8a813aa-c853-4740-aefd-16d60c38dbf7"
    resource_group_name = "terraform-storage-resources"
    # The name of the storage account in Azure
    storage_account_name = "terraformstorageem777"
    # The name of the azure blob container
    container_name = "terraformstatecontainer"
    # The name of the file to store in the blob container
    key = "terraform.tfstate"
  }
}

# Create a resource group in Azure
# azurerm_resource_group is the name of the type of resource for the azure provider
# res_group_1 is the name of the resource within this definition file
resource "azurerm_resource_group" "res_group_1" {
  # Resource group name in Azure (Home > Resource groups)
  name     = "terraform-resources"
  # Azure region
  location = "Australia East"
}

# Create a container instance in Azure
# azurerm_container_group is the name of the type of resource which corresponds to an Azure Container instance
# container_group1 is the name of the resource within this definition file
resource "azurerm_container_group" "container_group1" {
  # The name of the resource in Azure (in this case the name of the Container instance)
  name                = "weatherapi"
  # References to resource group in this file
  location            = azurerm_resource_group.res_group_1.location
  resource_group_name = azurerm_resource_group.res_group_1.name


  ip_address_type = "public"
  dns_name_label  = "emmanuel777mwa"
  os_type         = "Linux"


  container {
    # The name of the Container instance resource in Azure
    name          = "weatherapi"
    # Name of the image in Docker Hub to load into the Azure container
    image         = "emmanuelm777/weatherapi:${var.imagebuild}"
    cpu           = "1"
    memory        = "1"

    ports {
        port = 80
        protocol = "TCP"
    }

  }

}
