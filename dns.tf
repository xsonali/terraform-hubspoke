resource "azurerm_dns_zone" "austraweb_zone" {
  name                = "austraweb.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_dns_a_record" "root" {
  name                = "@" # Root domain
  zone_name           = azurerm_dns_zone.austraweb_zone.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = ["20.191.247.205"]
}

resource "azurerm_dns_a_record" "www" {
  name                = "www" # www subdomain
  zone_name           = azurerm_dns_zone.austraweb_zone.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = ["20.191.247.205"]
}

# Private DNS Zone for internal domain
resource "azurerm_private_dns_zone" "austra_internal" {
  name                = "austra.internal"
  resource_group_name = azurerm_resource_group.rg.name
}

# Link DNS zone to Hub VNet
resource "azurerm_private_dns_zone_virtual_network_link" "hub_link" {
  name                  = "hub-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.austra_internal.name
  virtual_network_id    = azurerm_virtual_network.hub.id
  registration_enabled  = true
}

# Link DNS zone to Spoke VNet
resource "azurerm_private_dns_zone_virtual_network_link" "spoke_link" {
  name                  = "spoke-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.austra_internal.name
  virtual_network_id    = azurerm_virtual_network.spoke.id
  registration_enabled  = false
}
