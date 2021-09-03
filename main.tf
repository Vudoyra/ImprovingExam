terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscriptionID
  tenant_id       = var.tenantID
  #client_id       = var.clientID
  #client_secret   = "2"
}

# Your code goes here