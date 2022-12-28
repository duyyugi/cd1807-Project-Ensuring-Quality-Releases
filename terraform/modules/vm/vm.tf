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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDB20Iwr110iURE8t98GDUqKpDOsVdCPfZIvpTotn49D5LyDp6wtxv32bhX5YpAUDUaXZKln0+QnceAEvuXHYt1G3aPasIUTVFHmoEkkggVvz4EJg0MpmwRix7VqhqXxw6aCQsD8Q0CrrJDlgFP0I2xAsOn5UTPJ6nQJnTFjOYZ+Klx565rxo0fzTebrr1zAEjr07Dul/P9lMHH3Se+RXCXXliFNOT51medsHrutjtiG6PlnBf1KG8cFT8YTglq5dDySOmUsbMyx0pphViDeZ9C/GdiLv91EEHRPopcROqff/gu7XJrApLO3J4eodnUHQwKh3z4dfnpSngGhJsBRBJFVMPD86HK6lSRrJlEoC8LOZm8e9nDbb+IwReQwsOAB2D1Kf8RqqkwVcsFFmEfZHTXz37rcomKcm1FEsmBPPk0gEGo+MpCfEtWs4+hjxBiBKTf2MmE8aMssD63UcGDCscPiaTyuJrEhXBEaP1pf4r8itYiW22h5XnBN4+b0FZTtQc= duy@cc-917dfe2f-7b94f9f79d-r5tmp"
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
