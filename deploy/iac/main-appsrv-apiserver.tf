locals {
  apiserver_name = "${replace(local.name_template, "<service>", "appsrv")}-api"
  apiserver_url  = var.custom_domain_name != "" ? "https://${var.custom_domain_name}" : "https://${local.apiserver_name}.azurewebsites.net"
}

resource "azurerm_linux_web_app" "appiserver" {
  name                = local.apiserver_name
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
      docker_image_name   = "dependencytrack/apiserver"
      docker_registry_url = "https://index.docker.io"
    }
  }
  identity { type = "SystemAssigned" }
  app_settings = merge({
    WEBSITES_PORT                    = 8080
    ALPINE_DATABASE_MODE             = "external"
    ALPINE_DATABASE_URL              = "jdbc:postgresql://${azurerm_postgresql_flexible_server.database-server.fqdn}:5432/${local.database-name}"
    ALPINE_DATABASE_DRIVER           = "org.postgresql.Driver"
    ALPINE_DATABASE_USERNAME         = local.database-user-name
    ALPINE_DATABASE_PASSWORD         = azurerm_key_vault_secret.database-user-password-secret.value
    ALPINE_OIDC_ENABLED              = true
    ALPINE_OIDC_ISSUER               = "https://login.microsoftonline.com/${var.tenant_id}/v2.0"
    ALPINE_OIDC_CLIENT_ID            = azuread_application.frontend.client_id
    ALPINE_OIDC_USERNAME_CLAIM       = "preferred_username"
    ALPINE_OIDC_TEAMS_CLAIM          = "groups"
    ALPINE_OIDC_USER_PROVISIONING    = true
    ALPINE_OIDC_TEAM_SYNCHRONIZATION = true
  })
}
