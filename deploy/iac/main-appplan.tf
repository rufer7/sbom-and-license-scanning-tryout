# app service on linux
resource "azurerm_service_plan" "appplan" {
  name                = replace(local.name_template, "<service>", "applan")
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default_location
  tags                = merge(var.service_tags, { description = "App Service Plan" })
  os_type             = "Linux"
  sku_name            = var.app_sku_name
  worker_count        = var.app_worker_count
}
