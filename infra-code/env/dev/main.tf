# terraform {
#   backend "azurerm" {
#     # Replace the values below with your backend storage account and container
#     storage_account_name = "rajatterraformsa"
#     container_name       = "rajatterraformcontainer"
#     key                  = "dev.terraform.tfstate"
#   }
# }

module "rg" {
  source = ".././modules/azurerm_resource_group"
  rgs = [
    {
      name     = "rajatrgdev"
      location = "eastus"
    }
  ]
}

module "network" {
  source = ".././modules/azurerm_networking"
  networks = [
    {
      name                = "rajatvnet"
      location            = var.location
      resource_group_name = module.rg.name
      address_space       = ["10.1.0.0/16"]
      subnets = [
        { name = "app", address_prefix = "10.1.1.0/24" },
      ]
    }
  ]
}

module "storage" {
  source = ".././modules/azurerm_storage_account"
  storage_accounts = [
    {
      name                = "rajatsa"
      location            = var.location
      resource_group_name = module.rg.name
    }
  ]
}

data "azurerm_client_config" "current" {}

module "keyvault" {
  source              = ".././modules/azurerm_key_vault"
  name                = "rajatvaultdev"
  location            = var.location
  resource_group_name = module.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

module "compute1" {
  source              = ".././modules/azurem_compute"
  name                = "rajatacidev"
  location            = var.location
  resource_group_name = module.rg.name
  container_image     = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
  container_port      = 80
  ip_address_type     = "Public"
  vms                 = []
}


