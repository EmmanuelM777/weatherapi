# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version             = "2.5.0"
  subscription_id     = "e8a813aa-c853-4740-aefd-16d60c38dbf7"
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "res_group_1" {
  name     = "terraform-resources"
  location = "Australia East"
}

resource "azurerm_container_group" "container_group1" {

  name                = "weatherapi"
  location            = azurerm_resource_group.res_group_1.location
  resource_group_name = azurerm_resource_group.res_group_1.name

  ip_address_type = "public"
  dns_name_label  = "emmanuel777mwa"
  os_type         = "Linux"

  container {
    name          = "weatherapi"
    # Name of the image in Docker Hub
    image         = "emmanuelm777/weatherapi"
    cpu           = "1"
    memory        = "1"

    ports {
        port = 80
        protocol = "TCP"
    }

  }

}
