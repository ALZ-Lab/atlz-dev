# Configure Terraform to set the required AzureRM provider
# version and features{} block

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
  #  backend "local" {
  #    path = "./connectivity.tfstate"
  #  }
  backend "azurerm" {
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-connectivity"
    key                  = "EnIZehd/NX1nYgYMTtlkcQiEH+u1XEjFT0GvDCaejz1TaRyQitFJLKrqPTx9WmJur4BPD0r6eBAD+AStlDDLAw=="
  #  use_oidc             = true                                   # Can also be set via `ARM_USE_OIDC` environment variable.
  #  client_id            = "250f1f11-bb48-49ac-8a91-c6f116098e33" # Can also be set via `ARM_CLIENT_ID` environment variable.
  #  subscription_id      = "6e06f118-5146-4357-a5cc-7329340def38" # Can also be set via `ARM_SUBSCRIPTION_ID` environment variable.
  #  tenant_id            = "20ead862-19d8-4495-94e5-366875e455a7" # Can also be set via `ARM_TENANT_ID` environment variable.
  }
}

# Define the provider configuration

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id_connectivity
}

# Get the current client configuration from the AzureRM provider

data "azurerm_client_config" "current" {}

# Declare the Azure landing zones Terraform module
# and provide the connectivity configuration

module "alz" {
  # To enable correct testing of our examples, we must source this
  # module locally. Please remove the local `source = "../../../"`
  # and uncomment the remote `source` and `version` below.
  # source = "../../../"
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "3.1.2"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # Base module configuration settings
  root_parent_id   = data.azurerm_client_config.current.tenant_id
  root_id          = var.root_id
  default_location = "westeurope"

  # Disable creation of the core management group hierarchy
  # as this is being created by the core module instance
  deploy_core_landing_zones = false

  # Configuration settings for connectivity resources
  deploy_connectivity_resources    = true
  configure_connectivity_resources = data.terraform_remote_state.connectivity.outputs.configuration
  subscription_id_connectivity     = data.terraform_remote_state.connectivity.outputs.subscription_id

}
