# Output the Resource Group name
output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "The name of the Azure Resource Group"
}

# Output the VM name
output "vm_name" {
  value       = azurerm_linux_virtual_machine.terra_vm.name
  description = "The name of the Linux VM"
}

# Output the VM size
output "vm_size" {
  value       = azurerm_linux_virtual_machine.terra_vm.size
  description = "The size (SKU) of the Linux VM"
}

# Output the public IP of the VM
output "vm_public_ip" {
  value       = azurerm_public_ip.terra_public_ip.ip_address
  description = "The public IP address of the Linux VM"
}

# Output the OS disk size
output "os_disk_size" {
  value       = azurerm_linux_virtual_machine.terra_vm.os_disk[0].disk_size_gb
  description = "The OS disk size of the Linux VM in GB"
}

# Output the extra attached managed disk size (if any)
output "managed_disk_size" {
  value       = azurerm_managed_disk.terra_disk.disk_size_gb
  description = "Size of the extra attached managed disk in GB"
}

