# Get the platform (connectivity, management & core) configuration
# settings from outputs via the respective terraform
# remote state files

/*
data "terraform_remote_state" "connectivity" {
  backend = "azurerm"

  config = {
    #  path = "${path.module}/../connectivity/connectivity.tfstate"
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-connectivity"
    key                  = "connectivity.tfstate"

    use_oidc             = true # Can also be set via `ARM_USE_OIDC` environment variable.
    #use_azuread_auth = true                                   # Can also be set via `ARM_USE_AZUREAD` environment variable.
    client_id       = "dbdb6f85-79c6-46ab-9345-f126bfb48a4f" # Can also be set via `ARM_CLIENT_ID` environment variable.
    client_secret   = "e9.8Q~sTEOJ3VS1Jh5nZJhKJZZawoO9mkyyHvbEM"
    subscription_id = "759832a6-6a24-4336-9248-d56d611d0df1" # Can also be set via `ARM_SUBSCRIPTION_ID` environment variable.
    tenant_id       = "20ead862-19d8-4495-94e5-366875e455a7" # Can also be set via `ARM_TENANT_ID` environment variable.

  }
}
*/
/*
data "terraform_remote_state" "management" {
  #  backend = "local"
  backend = "azurerm"

  config = {
    #  path = "${path.module}/../management/management.tfstate"
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-management"
    key                  = "management.tfstate"
  }
}

data "terraform_remote_state" "core" {
  backend = "azurerm"

  config = {
    #  path = "${path.module}/../core/core.tfstate"
    resource_group_name  = "rg-dev-tfstate"
    storage_account_name = "stadevtfstate"
    container_name       = "atlz-dev-core"
    key                  = "core.tfstate"
  }
}
*/
