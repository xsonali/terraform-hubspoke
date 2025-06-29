# vpn.tf
# Define VPN Gateway and related configuration here.

# VPN Gateway Public IP
resource "azurerm_public_ip" "vpngw_pip" {
  name                = "pip-vpngw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# VPN Gateway for Point-to-Site (P2S)
resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = "vpngw-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"

  ip_configuration {
    name                 = "vpngw-ipconfig"
    public_ip_address_id = azurerm_public_ip.vpngw_pip.id
    subnet_id            = azurerm_subnet.gateway_subnet.id
  }

  enable_bgp = false
    
  vpn_client_configuration {
  address_space = ["192.168.1.0/24"]
  # no root_certificate block here
  }
}
