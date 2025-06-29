# Route table for spoke subnet
resource "azurerm_route_table" "workload_route_table" {
  name                = "rt-workload-sn"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name                   = "default-to-nva"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }
}

resource "azurerm_subnet_route_table_association" "workload_sn_assoc" {
  subnet_id      = azurerm_subnet.spoke_subnet.id
  route_table_id = azurerm_route_table.workload_route_table.id
}

# Route table for GatewaySubnet to route traffic to the spoke
resource "azurerm_route_table" "gateway_to_spoke" {
  name                = "rt-gateway-to-spoke"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name                   = "spoke-via-nva"
    address_prefix         = "10.1.0.0/24" # Adjust as needed
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }
}

# Associate the route table with the GatewaySubnet
resource "azurerm_subnet_route_table_association" "gateway_subnet_assoc" {
  subnet_id      = azurerm_subnet.gateway_subnet.id
  route_table_id = azurerm_route_table.gateway_to_spoke.id
}
