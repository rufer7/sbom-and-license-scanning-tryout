# https://dev.azure.com/is-prod/isolutions/_wiki/wikis/Azure%20Guidelines/644/Azure-Resources-Naming-Convention

data "azurerm_client_config" "current" {}
data "azuread_domains" "aad_domains" {
  only_initial = true
}

locals {
  name_template = lower("${var.customer}-${var.env_code}-<service>-${var.solution_name}")
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = replace(local.name_template, "<service>", "rg")
  location = var.default_location
  tags     = merge(var.resource_group_tags, { description = "Sample Resource Group" })
}

resource "azuread_group" "role-rg-contributor" {
  display_name            = format("ra-%s-contributor", azurerm_resource_group.rg.name)
  description             = "Role group which grants contributor access to the group"
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
  description             = "Permission group granting contributor rights to the group"
  members                 = [azuread_group.role-rg-contributor.id]
  prevent_duplicate_names = true
  security_enabled        = true
  lifecycle {
    # apart from setting initially; do not flag changes in owners as state change
    ignore_changes = [owners]
  }
}

resource "azurerm_role_assignment" "rg-contributor" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.perm-rg-contributor.object_id
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}
