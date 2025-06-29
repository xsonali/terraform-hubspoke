# Public IP for the Linux Web VM 
resource "azurerm_public_ip" "web_vm_pip" {
  name                = "pip-web-vm-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# NIC for Windows VM (in spoke subnet)
resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.spoke_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "test_vm" {
  name                  = "testvm-win"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  admin_username        = "azureadmin"
  admin_password        = var.admin_password

  os_disk {
    name                 = "osdisk-winvm"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  computer_name            = "winvm"
  provision_vm_agent       = true
  enable_automatic_updates = true
}

# NIC for Linux Web VM (in DMZ subnet)
resource "azurerm_network_interface" "web_vm_nic" {
  name                = "nic-web-vm-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.dmz_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_vm_pip.id
  }
}

# Linux Web Virtual Machine
resource "azurerm_linux_virtual_machine" "web_vm_1" {
  name                            = "web-vm-1"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = var.vm_size
  network_interface_ids           = [azurerm_network_interface.web_vm_nic.id]
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = true

  os_disk {
    name                 = "osdisk-web-vm-1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("C:/Users/Alam/.ssh/azure_id_rsa.pub")
  }

  custom_data = filebase64("${path.module}/cloud-init-dns.yaml")

  computer_name              = "webvm1"
  provision_vm_agent         = true
  allow_extension_operations = true
}

# NIC for DNS VM (in DNS subnet of hub vnet)
resource "azurerm_network_interface" "dns_nic" {
  name                = "dns-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.DNSSubnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.4"
  }
}

# DNS Windows VM (in hub DNSSubnet)
resource "azurerm_windows_virtual_machine" "dns_vm" {
  name                  = "dns-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.dns_nic.id]
  admin_username        = "azureadmin"
  admin_password        = var.admin_password

  os_disk {
    name                 = "osdisk-dnsvm"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  computer_name            = "dns-vm"
  provision_vm_agent       = true
  enable_automatic_updates = true
}

# NIC for the NVA VM
resource "azurerm_network_interface" "nva_nic" {
  name                = "nic-nva-vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_forwarding_enabled = true # Updated argument name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.nva_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.firewall_private_ip
  }
}

# Linux VM acting as Virtual Appliance
resource "azurerm_linux_virtual_machine" "nva_vm" {
  name                            = "nva-vm"
  location                        = var.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = "Standard_B1s"
  network_interface_ids           = [azurerm_network_interface.nva_nic.id]
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = true

  os_disk {
    name                 = "osdisk-nva-vm"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("C:/Users/Alam/.ssh/azure_id_rsa.pub")
  }

  computer_name              = "nvavm"
  provision_vm_agent         = true
  allow_extension_operations = true
}
