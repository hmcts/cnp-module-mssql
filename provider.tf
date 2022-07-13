#Defining the provider
terraform {
    required_providers {
    azurerm = {
          source = "hashicorp/azurerm"
          version =">=2.0.0"
      }
    }
}
