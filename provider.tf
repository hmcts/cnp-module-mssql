#Defining the provider
terraform {
    required_providers {
    azurerm = {
          source = "hashicorp/azurerm"
          version = "3.97"
      }
    }
}
