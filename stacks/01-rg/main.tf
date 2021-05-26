terraform {

  backend "azurerm" {
    resource_group_name   = "tstate"
    storage_account_name  = "tstate09762"
    container_name        = "tstate"
    key                   = "rg.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }

  required_version = "= 0.15.0"
}

provider "azurerm" {
  features {}
}
