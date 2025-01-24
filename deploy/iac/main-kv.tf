# key vault
resource "azurerm_key_vault" "kv" {
  resource_group_name       = azurerm_resource_group.rg.name
  name                      = replace(local.name_template, "<service>", "kv")
  location                  = var.default_location
  enable_rbac_authorization = true
  tags                      = merge(var.service_tags, { description = "App Service Key Vault" })
  sku_name                  = "standard"
  tenant_id                 = var.tenant_id
}

resource "azurerm_role_assignment" "kv-apiserver-reader" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_web_app.appiserver.identity.0.principal_id
}

resource "azurerm_role_assignment" "kv-admin" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azuread_group.perm-rg-contributor.object_id
}

output "kv_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}
