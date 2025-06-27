terraform {
  backend "azurerm" {
    resource_group_name   = "PTutorial-rg"           # Your actual resource group name
    storage_account_name  = "ptutorial123"           # Your Azure Storage Account name
    container_name        = "ptstate"                # Blob container name for state files
    key                   = "terraform.tfstate"      # State file name
  }
}
