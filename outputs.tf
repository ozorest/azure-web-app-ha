
output "app_gw_id" {
  description = "ID do Application Gateway"
  value       = azurerm_application_gateway.appgateway.id
}

output "backend_address_pool_id" {
  description = "ID do Application Gateway Backend Address Pool"
  value       = azurerm_application_gateway.appgateway.backend_address_pool[0].id
}

output "public_ip" {
  description = "IP público do Application Gateway"
  value       = azurerm_public_ip.pip.ip_address
}

output "agw_ip_id" {
  description = "ID do IP Público"
  value       = azurerm_public_ip.pip.id
}
output "public_ip_fqdn" {
  value = azurerm_public_ip.pip.fqdn
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}

output "bastion_public_ip_address" {
  value = azurerm_public_ip.bastion_pip.ip_address
}

output "bastion_public_ip_fqdn" {
  value = azurerm_public_ip.bastion_pip.fqdn
}
