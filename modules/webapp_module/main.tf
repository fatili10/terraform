provider "azurerm" {
  features {}
  subscription_id = "029b3537-0f24-400b-b624-6058a145efe1" 
}

# Référencer le groupe de ressources existant
data "azurerm_resource_group" "existing_rg" {
  name = "de_p1_resource_group"  
}

# Référencer l'App Service Plan existant
data "azurerm_app_service_plan" "existing_service_plan" {
  name                = "de_p1_service_plan"  
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

# Référencer le Virtual Network existant
data "azurerm_virtual_network" "existing_vnet" {
  name                = "de_p1_vnet" 
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}

# Créer une Web App
resource "azurerm_app_service" "web_app" {
  name                = "fatwebbapp2024"  
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  app_service_plan_id = data.azurerm_app_service_plan.existing_service_plan.id

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"  
  }

  # Pour utiliser le Virtual Network
  https_only = true  # Pour forcer HTTPS (optionnel)
}


