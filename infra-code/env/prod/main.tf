variable "rgs" {
  description = "Resource groups to create"
  type        = map(object({
    name     = string
    location = string
  }))
}

variable "networks" {
  description = "Virtual networks to create"
  type        = map(object({
    name              = string
    location          = string
    address_space     = list(string)
    resource_group_name = string
  }))
  default = {}
}

variable "public_ips" {
  description = "Public IPs to create"
  type        = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
  default = {}
}

variable "key_vaults" {
  description = "Key vaults to create"
  type        = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
  default = {}
}

variable "location" {
  description = "Default Azure region"
  type        = string
  default     = "eastus"
}

variable "vms" {
  description = "Virtual machines to create"
  type        = map(object({
    name = string
  }))
  default = {}
}

variable "storage_accounts" {
  description = "Storage accounts to create"
  type        = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
  default = {}
}
