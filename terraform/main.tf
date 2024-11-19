provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Crear un grupo de recursos
resource "azurerm_resource_group" "topicos_grupo_MAJEC_rg" {
  name     = "topicos_grupo_MAJEC_rg"
  location = "East US"
}

# Crear una red virtual
resource "azurerm_virtual_network" "topicos_grupo_MAJEC_vnet" {
  name                = "topicos_grupo_MAJEC_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.topicos_grupo_MAJEC_rg.location
  resource_group_name = azurerm_resource_group.topicos_grupo_MAJEC_rg.name
}

# Crear una subred
resource "azurerm_subnet" "topicos_grupo_MAJEC_subnet" {
  name                 = "topicos_grupo_MAJEC_subnet"
  resource_group_name  = azurerm_resource_group.topicos_grupo_MAJEC_rg.name
  virtual_network_name = azurerm_virtual_network.topicos_grupo_MAJEC_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Crear una interfaz de red para la VM
resource "azurerm_network_interface" "topicos_grupo_MAJEC_nic" {
  name                = "topicos_grupo_MAJEC_nic"
  location            = azurerm_resource_group.topicos_grupo_MAJEC_rg.location
  resource_group_name = azurerm_resource_group.topicos_grupo_MAJEC_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.topicos_grupo_MAJEC_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Crear una máquina virtual
resource "azurerm_linux_virtual_machine" "topicos_grupo_MAJEC_vm" {
  name                = "topicos_grupo_MAJEC_vm"
  resource_group_name = azurerm_resource_group.topicos_grupo_MAJEC_rg.name
  location            = azurerm_resource_group.topicos_grupo_MAJEC_rg.location
  size                = "Standard_B1ls"

  admin_username = "adminuser"
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.topicos_grupo_MAJEC_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # Definir el nombre de la computadora sin caracteres especiales
  computer_name = "topicosgrupoMAJECvm" 

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/Users/PC/.ssh/id_rsa.pub")  
  }
}
