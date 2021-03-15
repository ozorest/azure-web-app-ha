resource "azurerm_public_ip" "bastion_pip" {
    name                         = "${var.project}-bastion-pip"
    resource_group_name          = azurerm_resource_group.rg.name
    location                     = azurerm_resource_group.rg.location
    allocation_method            = "Static"
    domain_name_label            = "${var.project}-bastion"
}

resource "azurerm_network_security_group" "bastion_nsg" {
    name                = "${var.project}-bastion-nsg"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "allow_SSH_in_all"
        description                = "Allow SSH in from all locations"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_interface" "bastion_nic" {
    name                      = "${var.project}-bastion-nic"
    location                  = azurerm_resource_group.rg.location
    resource_group_name       = azurerm_resource_group.rg.name

    ip_configuration {
        name                          = "${var.project}-bastion-ipconfig"
        subnet_id                     = azurerm_subnet.backend.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.bastion_pip.id
    }
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name              = "${var.project}-bastion"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.machine_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.bastion_nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.private_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

resource "azurerm_network_interface_security_group_association" "nic-sg-assoc" {
  network_interface_id      = azurerm_network_interface.bastion_nic.id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id
}