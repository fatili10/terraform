provider "azurerm" {
  features {}
  subscription_id = "029b3537-0f24-400b-b624-6058a145efe1"  # Ton Subscription ID
}

# Référencer le groupe de ressources existant
data "azurerm_resource_group" "existing_rg" {
  name = "de_p1_resource_group"  # Nom du groupe de ressources existant
}

# # Créer un réseau virtuel
# resource "azurerm_virtual_network" "vnet" {
#   name                = "de_p1_vnet"  # Nom du Virtual Network
#   address_space       = ["10.0.0.0/16"]
#   location            = data.azurerm_resource_group.existing_rg.location
#   resource_group_name = data.azurerm_resource_group.existing_rg.name
# }

# # Créer une sous-réseau
# resource "azurerm_subnet" "subnet" {
#   name                 = "default"  # Nom de la sous-réseau
#   resource_group_name  = data.azurerm_resource_group.existing_rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.0.1.0/24"]  # Préfixe d'adresse pour le sous-réseau
# }

# # Créer un groupe de sécurité réseau
# resource "azurerm_network_security_group" "nsg" {
#   name                = "myNetworkSecurityGroup"  # Nom du NSG
#   location            = data.azurerm_resource_group.existing_rg.location
#   resource_group_name = data.azurerm_resource_group.existing_rg.name

#   # Règle pour autoriser le SSH (port 22)
#   security_rule {
#     name                       = "Allow_SSH"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"  # Port pour SSH
#     source_address_prefix      = "*"
#     destination_address_prefix  = "*"
#   }

#   # Règle pour autoriser le trafic sortant (tous les ports)
#   security_rule {
#     name                       = "Allow_All_Outbound"
#     priority                   = 200
#     direction                  = "Outbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix  = "*"
#   }
# }

# # Créer une adresse IP publique
# resource "azurerm_public_ip" "public_ip" {
#   name                = "myPublicIP"  # Nom de l'adresse IP publique
#   location            = data.azurerm_resource_group.existing_rg.location
#   resource_group_name = data.azurerm_resource_group.existing_rg.name
#   allocation_method   = "Dynamic"
# }

# # Créer une interface réseau
# resource "azurerm_network_interface" "nic" {
#   name                = "myNetworkInterface"  # Nom de l'interface réseau
#   location            = data.azurerm_resource_group.existing_rg.location
#   resource_group_name = data.azurerm_resource_group.existing_rg.name

#   ip_configuration {
#     name                          = "internal"  # Nom de la configuration IP
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.public_ip.id

#     # Attacher le NSG à la configuration IP
#     # network_security_group_ids     = [
#     #   "/subscriptions/029b3537-0f24-400b-b624-6058a145efe1/resourceGroups/de_p1_resource_group/providers/Microsoft.Network/networkInterfaces/el_jattioui_fatima_nic"]
 

#   }
# }

# Créer une machine virtuelle
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "fatima1234VM"  # Nom de la VM
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  size                = "Standard_B1s"  # Type de VM (1 vCPU, 1 Go de RAM)
  admin_username      = "azureuser"  # Nom d'utilisateur pour la VM
  admin_password      = "F@tima2024Simplon!"
  disable_password_authentication = false  # Mot de passe pour l'utilisateur (doit respecter les exigences de complexité)

  network_interface_ids = [
    "/subscriptions/029b3537-0f24-400b-b624-6058a145efe1/resourceGroups/de_p1_resource_group/providers/Microsoft.Network/networkInterfaces/el_jattioui_fatima_nic"
  ]

  os_disk {
    name = "fatel"
    caching  = "ReadWrite"
    storage_account_type = "Standard_LRS"
 
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  # }
  # admin_ssh_key {
  #   username   = "azureuser"
  #   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6q75ugVv9pHv635iGdP61Y0VdZuRvSn1gi+/aPcTwmBhaKhtOTKjo8Lzh32j+jwZG2DrogWpRTrxVA79B+usmol8Lq4xexKWyuFTTGuIRUSIBc4QTZsK9oneFqu8nLN1zUclcfM7W91v05l5VSOfU+DphPnX5NMV0cF3CqMnsy+P7b0DW7yNyksRiQpq2zIAdR03cT+8diidA8ndaWlr8jEvbGM+YRWW4a+TM3iUmpmeISaob+r9REGUoBD5Jyff2FNz930hzX0X0RFdVSZTjLrYjrzDPlwGgA89x4RNlj8cdji0mBppPoxxzxjy/Ej9ioNHEcTJ0WmWxg9ClarHV Utilisateur@HDFPCCND7284M91"  
  # }
  }
}
