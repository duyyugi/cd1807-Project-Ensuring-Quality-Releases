resource "azurerm_network_interface" "nic" {
  name                = "${var.application_type}-${var.resource_type}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.application_type}-${var.resource_type}-vm"
  location              = var.location
  resource_group_name   = var.resource_group
  size                  = "Standard_DS2_v2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIpyZS497+1jSqDXHcCKqj8fhhVmEuaoQskZ1FPeCeKMm0B2nkpLf/L7ioEECBDOwFL7zhBz+bBuGs7lHaaIIdcdhdzNGVKESqZb/eV0PxSwNmAVWiFIspEt2BdJXWwc7MA4TE1piSMqeiyfmTnTytoN3vMY2oX5MNASmpt4x8NSpu82A2l/HnKmjkWBL7lUtwuywyXFcRFSOGYF7oJAOq4FtCiu+ZKr5hQiVODyjerZ650oMlKePRDMDZUb3Xsxx0Mjs/D5IbmJkuiO6ByUUoxTjQaBjkcQQimYzBa/W9Wig0ZHL20pVHAry4iZdj/U7BUYVgw7ulXNW0ph6pwWFUNDbU/iHJCWqhGviD8u4DCB8K+gNRLpzA4GQb1KGKY/BEu0tYhIFCQ3OH/ndG86TYJqq3rNRKheIGuwbd2T/bN3PBIWiVMWh9ilUj+dmVIjGvkSon91fWuebceJDn4WTPIeLxcvC9TEwvRUZtuqhrJl2J1aFIsG3aXklP8HQM16c= admin@LAPTOP-23M2EG9T"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
