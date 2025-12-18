resource "azurerm_virtual_network" "virtual_networks" {
	for_each = var.networks

	name                = each.value.name
	resource_group_name = each.value.resource_group_name
	location            = each.value.location
	address_space       = each.value.address_space
	tags                = lookup(each.value, "tags", {})

	dynamic "subnet" {
		for_each = lookup(each.value, "subnets", [])
		content {
			name             = subnet.value.name
			address_prefixes = subnet.value.address_prefixes
		}
	}
}

resource "azurerm_network_security_group" "nsgs" {
	for_each = var.networks

	name                = "${each.value.name}-nsg"
	location            = each.value.location
	resource_group_name = each.value.resource_group_name
	tags                = lookup(each.value, "tags", {})
}

resource "azurerm_subnet_network_security_group_association" "subnets" {
	for_each                  = azurerm_subnet.subnets
	subnet_id                 = each.value.id
	network_security_group_id = azurerm_network_security_group.nsgs[each.key].id
}
