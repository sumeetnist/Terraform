terraform {
  required_providers {
    azurerm={
        source="hashicorp/azurerm"
        version="3.17.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "41789fcc-7af0-45bd-8a60-8b88b0b43edd"
  tenant_id = "a532d2e4-1e23-42de-b9e0-1d0c59f077b9"
  client_id = "b9525c43-1925-47da-9316-d7a643774130"
  client_secret = "3aR8Q~b8vZDMqvUetz~T8ZiZJMm3KqCGpYSWYaUx"
  features {    
  }
}

resource "azurerm_service_plan" "tlplan001" {
  name                = "tlplan001"
  resource_group_name = "MyRG"
  location            = "East US"
  os_type             = "Windows"
  sku_name            = "F1"
}

resource "azurerm_windows_web_app" "tlapp001" {
  name                = "tlapp001"
  resource_group_name = "MyRG"
  location            = "East US"
  service_plan_id     = azurerm_service_plan.tlplan001.id

  site_config {
    always_on = false
    application_stack{
        current_stack="dotnet"
        dotnet_version="v6.0"
    }
  }

  depends_on = [
    azurerm_service_plan.tlplan001
  ]
}
