resource "null_resource" "copy-ssh" {
  depends_on = [ azurerm_linux_virtual_machine.jump_host ]
  #once my jump host get created then only this resource block should execute
  #using jump host i ll create a connection to the vm
  connection {
    type = "ssh" #RDP
    host = azurerm_linux_virtual_machine.jump_host.public_ip_address
    user = azurerm_linux_virtual_machine.jump_host.admin_username
    private_key = file("${path.module}/ssh/terraform-azure.pem")
  }
  #using the startup script we launch an vm and install mariadb or mysql database
  provisioner "file" {
       source = "ssh/terraform-azure.pem" #this will your local machine mysql.dumps
       destination = "/tmp/terraform-azure.pem" #remote machine
  }
  provisioner "remote-exec" {
      inline = [
        "sudo chmod 400 /tmp/terraform-azure.pem"
        #mysql db_name < backup-file.sql
      ]
  }
}