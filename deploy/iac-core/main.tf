data "azurerm_client_config" "current" {}

locals {
  name_template       = lower("${var.customer}-${var.env_code}-<service>-iac")
  name_template_short = lower("${var.customer}${var.env_code}<service>iac")
  existing_rg         = "existing_rg"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = replace(local.name_template, "<service>", "rg")
  location = var.default_location
  tags     = var.resource_group_tags
}

resource "azuread_group" "role-rg-contributor" {
  display_name            = format("ra-%s-contributor", azurerm_resource_group.rg.name)
  prevent_duplicate_names = true
  security_enabled        = true
  members                 = [data.azurerm_client_config.current.object_id]
  lifecycle {
    # apart from setting initially; do not flag changes in members and owners as state change
    ignore_changes = [members, owners]
  }
}

resource "azuread_group" "perm-rg-contributor" {
  display_name            = format("pm-%s-contributor", azurerm_resource_group.rg.name)
  members                 = [azuread_group.role-rg-contributor.id]
  prevent_duplicate_names = true
  security_enabled        = true
  lifecycle {
    # apart from setting initially; do not flag changes in owners as state change
    ignore_changes = [owners]
  }
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  resource_group_name             = azurerm_resource_group.rg.name
  name                            = format("%s01", replace(local.name_template_short, "<service>", "stor"))
  location                        = var.default_location
  tags                            = var.service_tags
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  min_tls_version                 = "TLS1_2"
}

# container iac-state
resource "azurerm_storage_container" "tfstate" {
  name                 = "tfstate"
  storage_account_name = azurerm_storage_account.sa.name
}

# iac key vault
resource "azurerm_key_vault" "kv" {
  resource_group_name       = azurerm_resource_group.rg.name
  name                      = replace(local.name_template, "<service>", "kv")
  location                  = var.default_location
  enable_rbac_authorization = true
  tags = merge(
    var.service_tags,
  { description = "IaC Key Vault" })
  sku_name  = "standard"
  tenant_id = var.tenant_id
}

resource "azurerm_role_assignment" "blob-data-owner" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azuread_group.perm-rg-contributor.object_id
}

resource "azurerm_role_assignment" "kv-admin" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azuread_group.perm-rg-contributor.object_id
}

resource "azurerm_role_assignment" "rg-contributor" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.perm-rg-contributor.object_id
}
