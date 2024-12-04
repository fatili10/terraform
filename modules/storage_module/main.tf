# Fournisseur Azure
provider "azurerm" {
  features {}
  
  subscription_id = "029b3537-0f24-400b-b624-6058a145efe1" 
}
# Utiliser un groupe de ressources existant
data "azurerm_resource_group" "existing_rg" {
  name = "de_p1_resource_group"  
}

# Créer un compte de stockage
resource "azurerm_storage_account" "storage_account" {
  name                     = "fatstorage123456" 
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Créer un Blob Container
resource "azurerm_storage_container" "blob_container" {
  name                  = "raw-data"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"  
}
