variable "key_vaults" {
  description = "Map of key vaults to create"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tenant_id           = optional(string)
    sku_name            = optional(string, "standard")
    purge_protection    = optional(bool, true)
    soft_delete_days    = optional(number, 7)
    tags                = optional(map(string), {})
  }))
}
