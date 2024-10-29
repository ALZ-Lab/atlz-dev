
# Configure Terraform to set the required AzureRM provider
# version and features{} block

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.96.0"
    }
  }

  #  backend "local" {
  #    path = "./connectivity.tfstate"
  #  }
  backend "azurerm" {
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-connectivity"
    key                  = "connectivity.tfstate"
    # access_key is provided via environment variable ARM_ACCESS_KEY
  }
}

# Define the provider configuration

provider "azurerm" {
  features {}

  # subscription_id = var.subscription_id_connectivity

  # These values will be provided via GitHub Actions environment variables
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # tenant_id       = var.tenant_id
}

# Get the current client configuration from the AzureRM provider

#data "azurerm_client_config" "current" {}

# Declare the Azure landing zones Terraform module
# and provide the connectivity configuration

module "alz" {
  # To enable correct testing of our examples, we must source this
  # module locally. Please remove the local `source = "../../../"`
  # and uncomment the remote `source` and `version` below.
  # source = "../../../"
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "4.2.0"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # Base module configuration settings
  #root_parent_id   = data.azurerm_client_config.current.tenant_id
  #root_id          = var.root_id
  root_parent_id   = "20ead862-19d8-4495-94e5-366875e455a7"
  root_id          = var.root_id
  default_location = "westeurope"

  # Disable creation of the core management group hierarchy
  # as this is being created by the core module instance
  deploy_core_landing_zones = false

  # Configuration settings for connectivity resources
  deploy_connectivity_resources    = true
  configure_connectivity_resources = local.configure_connectivity_resources
  #subscription_id_connectivity     = var.subscription_id_connectivity

}
variable "client_id" {}
variable "client_secret" {}
