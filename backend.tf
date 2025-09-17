terraform {
  backend "azurerm" {
    storage_account_name = var.storage_account_name
    container_name = "backend"
    key = "terraform.tfstate"
    access_key = ""
  }
}
