resource "azurerm_route_table" "workload_route_table" {
  name                = "rt-workload-sn"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name                   = "default-to-nva"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip # Your NVA private IP, e.g. 10.0.2.10
  }
}

resource "azurerm_subnet_route_table_association" "workload_sn_assoc" {
  subnet_id      = azurerm_subnet.spoke_subnet.id # Subnet to route via NVA
  route_table_id = azurerm_route_table.workload_route_table.id
}
