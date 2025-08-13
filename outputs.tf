/* 
output → Keyword that says, “I want Terraform to show this info after running.”
<OUTPUT_NAME> → A label you choose (e.g., "resource_group_name").
value → The actual data to display. Often comes from a resource you created.
*/

# Resource Group Name
output "resource_group_name" {
  value       = azurerm_resource_group.main.name
  description = "The name of the Resource Group"
}

# Virtual Network Name
output "vnet_name" {
  value       = azurerm_virtual_network.main.name
  description = "The name of the Virtual Network"
}

# Public IP Address of the VM
output "vm_public_ip" {
  value       = azurerm_public_ip.main.ip_address
  description = "The public IP address to connect to the VM"
}

# VM Name
output "vm_name" {
  value       = azurerm_linux_virtual_machine.main.name
  description = "The name of the Virtual Machine"
}

# Admin Username
output "admin_username" {
  value       = azurerm_linux_virtual_machine.main.admin_username
  description = "The admin username for the VM"
}
