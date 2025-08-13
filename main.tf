# resource "null_resource" "file" {
#     provisioner "local-exec" {
#         command = "echo 'Message : ${upper("hello world!")}' > challenge.txt"
#     }
  
# }
#-------------------------------------------------------------------------------------------

# Project ki Requirements kia hain tells to download azurecli pehley uska version and kahan se

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

#-------------------------------------------

/*Connection Settings uses az login to auth the details and stuff the secrets basically 
it says Use the Azure provider we declared above.*/

provider "azurerm" {
  features {}
}

# Resource Block

/* A resource block in Terraform is the instruction to actually 
create something in your cloud (or destroy/update it later).*/

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}


# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.resource_group_name}-vnet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
}
# -------------------------------------------
# Subnet
# A subnet is a smaller network inside the VNet where your VM will connect.
resource "azurerm_subnet" "main" {
  name                 = "${var.resource_group_name}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# -------------------------------------------
# Public IP
# Gives your VM an external IP so you can SSH into it.
resource "azurerm_public_ip" "main" {
  name                = "${var.resource_group_name}-public-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Dynamic"
}

# -------------------------------------------
# Network Security Group (Firewall Rules)
# Controls inbound/outbound traffic to your VM.
resource "azurerm_network_security_group" "main" {
  name                = "${var.resource_group_name}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# -------------------------------------------
# Network Interface
# Connects the VM to the subnet, public IP, and security group.
resource "azurerm_network_interface" "main" {
  name                = "${var.resource_group_name}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# Associate the NIC with the NSG
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# -------------------------------------------
# Virtual Machine (Linux Example)
# Creates the actual VM resource in Azure.
resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.resource_group_name}-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_username

  # SSH authentication
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  network_interface_ids = [azurerm_network_interface.main.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}