# This service principal is used to login to "Dependency Track" and use delegated access to resources
resource "azuread_application" "frontend" {
  display_name            = "Dependency-Track ${var.stage == "prod" ? "" : " - ${var.env_code}"}"
  identifier_uris         = []
  sign_in_audience        = "AzureADMyOrg"
  logo_image              = filebase64(var.app_logo_name)
  group_membership_claims = ["All"]
  single_page_application {
    redirect_uris = ["${local.frontend_url}/static/oidc-callback.html"]
  }
  api {
    requested_access_token_version = 2
  }
  optional_claims {
    access_token {
      name      = "groups"
      essential = false
    }
    id_token {
      name      = "groups"
      essential = false
    }
    saml2_token {
      name      = "groups"
      essential = false
    }
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"
    resource_access {
      id   = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0"
      type = "Scope"
    }
    resource_access {
      id   = "bc024368-1153-4739-b217-4326f2e966d0"
      type = "Scope"
    }
    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e"
      type = "Scope"
    }
    resource_access {
      id   = "14dad69e-099b-42c9-810b-d002981feec1"
      type = "Scope"
    }
  }
}
