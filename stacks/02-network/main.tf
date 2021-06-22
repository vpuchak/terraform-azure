terraform {
  backend "azurerm" {
    resource_group_name  = "tstate"
    storage_account_name = "tstate097624"
    container_name       = "tstate"
    key                  = "network.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }

  required_version = "= 1.0.0"
}

provider "azurerm" {
  features {}
}
