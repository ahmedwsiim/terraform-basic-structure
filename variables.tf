# Resource Group Name
variable "resource_group_name" {
  type        = string
  description = "Name for the Azure Resource Group"
  default     = "my_resource_group"
}

# Location for Resources
variable "location" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "East US"
}

# VM Size
variable "vm_size" {
  type        = string
  description = "Azure VM size (SKU)"
  default     = "Standard_B1s"
}

# Admin Username
variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "azureuser"
}

# SSH Public Key
# You can generate one with: ssh-keygen -t rsa -b 4096
variable "ssh_public_key" {
  type        = string
  description = "Public SSH key to access the VM"
}

# VM Name
variable "vm_name" {
  type        = string
  description = "Name for the Virtual Machine"
  default     = "my-vm"
}
