locals {
  frontend_name = replace(local.name_template, "<service>", "appsrv")
  frontend_url  = var.custom_domain_name != "" ? "https://${var.custom_domain_name}" : "https://${local.frontend_name}.azurewebsites.net"
}

resource "azurerm_linux_web_app" "frontend" {
  name                = local.frontend_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.default_location
  tags                = merge(var.service_tags, { description = "App Service" })
  service_plan_id     = azurerm_service_plan.appplan.id
  https_only          = true

  site_config {
    app_command_line = ""
    always_on        = true
    ftps_state       = "FtpsOnly"
    application_stack {
      docker_image_name   = "dependencytrack/frontend"
      docker_registry_url = "https://index.docker.io"
    }
  }
  identity { type = "SystemAssigned" }
  app_settings = merge({
    API_BASE_URL   = local.apiserver_url
    OIDC_ISSUER    = "https://login.microsoftonline.com/${var.tenant_id}/v2.0"
    OIDC_CLIENT_ID = azuread_application.frontend.client_id
    WEBSITES_PORT  = 8080
  })
}
