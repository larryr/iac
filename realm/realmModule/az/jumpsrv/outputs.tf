

output "jumsrv_ip" {
  description = "Jumpbox VM IP"
  value       = azurerm_linux_virtual_machine.jumpsrv.public_ip_address
}

