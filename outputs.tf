# outputs.tf
# Define outputs to export resource data.
# outputs.tf

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "firewall_public_ip" {
  description = "Public IP address of the Azure Firewall"
  value       = azurerm_public_ip.firewall_pip.ip_address
}

output "web_vm_public_ip" {
  description = "Public IP address of the Web VM"
  value       = azurerm_public_ip.web_vm_pip.ip_address
}

output "web_vm_private_ip" {
  description = "Private IP address of the Web VM NIC"
  value       = azurerm_network_interface.web_vm_nic.private_ip_address
}

output "windows_vm_private_ip" {
  description = "Private IP address of the Windows VM NIC"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "dns_vm_private_ip" {
  description = "Private IP address of the DNS VM NIC"
  value       = azurerm_network_interface.dns_nic.private_ip_address
}

output "vpn_gateway_public_ip" {
  description = "Public IP address of the VPN Gateway"
  value       = azurerm_public_ip.vpngw_pip.ip_address
}

output "web_vm_name" {
  description = "Name of the Web VM"
  value       = azurerm_linux_virtual_machine.web_vm_1.name
}

output "windows_vm_name" {
  description = "Name of the Windows VM"
  value       = azurerm_windows_virtual_machine.test_vm.name
}

output "dns_vm_name" {
  description = "Name of the DNS VM"
  value       = azurerm_windows_virtual_machine.dns_vm.name
}

output "dns_zone_name" {
  value = azurerm_private_dns_zone.austra_internal.name
}
