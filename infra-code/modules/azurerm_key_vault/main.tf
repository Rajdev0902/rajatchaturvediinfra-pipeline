variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "standard"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each                    = var.key_vaults
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  tenant_id                   = lookup(each.value, "tenant_id", data.azurerm_client_config.current.tenant_id)
  sku_name                    = lookup(each.value, "sku_name", "standard")
  purge_protection_enabled    = lookup(each.value, "purge_protection", true)
  soft_delete_retention_days  = lookup(each.value, "soft_delete_days", 7)

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["Get"]
    secret_permissions = ["Get"]
    storage_permissions = ["Get"]
  }

  tags = lookup(each.value, "tags", {})
}

output "key_vault_ids" {
  value = { for k, v in azurerm_key_vault.kv : k => v.id }
}
resource "azurerm_key_vault" "this" {
	name                        = var.name
	location                    = var.location
	resource_group_name         = var.resource_group_name
	tenant_id                   = var.tenant_id
	sku_name                    = var.sku_name
	purge_protection_enabled    = true
	soft_delete_retention_days  = 7

	network_acls {
		bypass = "AzureServices"
		default_action = "Deny"
	}
}
