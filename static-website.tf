# Provider Block
provider "azurerm" {
 features {}          
}

# Resource group creation
resource "azurerm_resource_group" "myrg4" {
  name     = var.resource_group_name
  location = var.location

}

# Storage account creation
resource "azurerm_storage_account" "websitestorage" {
  name                     = "${var.storage_account_name}${random_string.myrandom.id}"
  access_tier              = var.storage_access_tier
  location                 = var.location
  account_kind             = var.storage_account_kind
  account_replication_type = var.storage_account_replication_type
  account_tier             = var.storage_account_tier
  resource_group_name      = azurerm_resource_group.myrg4.name
  


}

resource "azurerm_storage_account_static_website" "testweb" {
  storage_account_id = azurerm_storage_account.websitestorage.id
  error_404_document = var.static_website_error_404_document
  index_document     = var.static_website_index_document
}