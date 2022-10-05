# resource "azurerm_linux_virtual_machine" "primary" {
#   name                = var.primary_linux_vm_name
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   size                = var.primary_linux_vm_size
#   admin_username      = var.primary_linux_vm_adminuser

#   network_interface_ids = [
#     var.vm_nic_id,
#   ]

#   # admin_ssh_key {
#   #   username   = "adminuser"
#   #   public_key = var.main_vm_key
#   # }


#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }
# }
