output "jum_host_public_ip" {
  description = "this is the jump host public ip"
  value = azurerm_linux_virtual_machine.jump_host.public_ip_addresses
}