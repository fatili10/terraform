provider "azurerm" {
  features {}
  subscription_id = "029b3537-0f24-400b-b624-6058a145efe1"
}

# Appeler le module VM
module "vm_module" {
  source = "./modules/vm_module"
}

# Appeler le module Storage
module "storage_module" {
  source = "./modules/storage_module"
}

# Appeler le module WebApp
module "webapp_module" {
  source = "./modules/webapp_module"
}