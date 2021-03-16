data "template_file" "custom_data" {
  template = var.cloud_init_path != "" ? file(var.cloud_init_path) : file("${path.module}/cloud-init.txt")
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = "${var.project}-vmss"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  sku                             = var.machine_size
  instances                       = var.nodes
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  custom_data                     = base64encode(data.template_file.custom_data.rendered)

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.private_key_path)
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.backend.id
      application_gateway_backend_address_pool_ids = azurerm_application_gateway.appgateway.backend_address_pool.*.id
    }
  }
}