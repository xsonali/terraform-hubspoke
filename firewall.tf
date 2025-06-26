# firewall.tf
# Define Azure Firewall and NAT/Application rules here.
# Public IP for Firewall
resource "azurerm_public_ip" "firewall_pip" {
  name                = "pip-fw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall
resource "azurerm_firewall" "firewall" {
  name                = "fw-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "fw-ipconfig"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

# NAT Rule Collection: RDP to Windows VM
resource "azurerm_firewall_nat_rule_collection" "rdp_nat_rule" {
  name                = "rdp"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 200
  action              = "Dnat"

  rule {
    name                  = "rdp-nat"
    protocols             = ["TCP"]
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
    destination_ports     = ["3389"]
    translated_address    = azurerm_network_interface.vm_nic.private_ip_address
    translated_port       = "3389"
  }
}

# NAT Rule Collection: SSH to Linux Web VM
resource "azurerm_firewall_nat_rule_collection" "linux_ssh_nat_rule" {
  name                = "linux-ssh"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 210
  action              = "Dnat"

  rule {
    name                  = "ssh-to-web-vm-1"
    protocols             = ["TCP"]
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
    destination_ports     = ["22"]
    translated_address    = azurerm_network_interface.web_vm_nic.private_ip_address
    translated_port       = "22"
  }
}

# NAT Rule Collection: HTTP/HTTPS to Linux Web VM
resource "azurerm_firewall_nat_rule_collection" "web_http_https_nat_rule" {
  name                = "web-nat"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 220
  action              = "Dnat"

  rule {
    name                  = "http-to-web-vm"
    protocols             = ["TCP"]
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
    destination_ports     = ["80"]
    translated_address    = azurerm_network_interface.web_vm_nic.private_ip_address
    translated_port       = "80"
  }

  rule {
    name                  = "https-to-web-vm"
    protocols             = ["TCP"]
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
    destination_ports     = ["443"]
    translated_address    = azurerm_network_interface.web_vm_nic.private_ip_address
    translated_port       = "443"
  }
}

# Application Rule Collection: Allow Microsoft domains
resource "azurerm_firewall_application_rule_collection" "allow_microsoft" {
  name                = "AllowMicrosoftAccess"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 110
  action              = "Allow"

  rule {
    name             = "AllowMicrosoftSites"
    source_addresses = ["10.1.0.0/24"]

    protocol {
      port = 80
      type = "Http"
    }

    protocol {
      port = 443
      type = "Https"
    }

    target_fqdns = ["*.microsoft.com"]
  }
}
