locals {
    rmourasp-location       = "eastus"
    rmourasp-resource-group = "rmourasp-vnet-rg"
    prefix-rmourasp         = "rmourasp"
}

resource "azurerm_resource_group" "rmourasp-vnet-rg" {
    name     = local.rmourasp-resource-group
    location = local.rmourasp-location
}

resource "azurerm_virtual_network" "rmourasp-vnet" {
    name                = "rmourasp-vnet"
    location            = azurerm_resource_group.rmourasp-vnet-rg.location
    resource_group_name = azurerm_resource_group.rmourasp-vnet-rg.name
    address_space       = ["192.168.0.0/16"]

    tags = {
    environment = local.prefix-rmourasp
    }
}

resource "azurerm_subnet" "rmourasp-private-subnet" {
    name                 = "PrivateSubnet"
    resource_group_name  = azurerm_resource_group.rmourasp-vnet-rg.name
    virtual_network_name = azurerm_virtual_network.rmourasp-vnet.name
    address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "rmourasp-public-subnet" {
    name                 = "PublicSubnet"
    resource_group_name  = azurerm_resource_group.rmourasp-vnet-rg.name
    virtual_network_name = azurerm_virtual_network.rmourasp-vnet.name
    address_prefixes     = ["192.168.2.0/24"]
}

resource "azurerm_subnet" "rmourasp-isolate-subnet" {
    name                 = "IsolatedSubnet"
    resource_group_name  = azurerm_resource_group.rmourasp-vnet-rg.name
    virtual_network_name = azurerm_virtual_network.rmourasp-vnet.name
    address_prefixes     = ["192.168.3.0/24"]
}