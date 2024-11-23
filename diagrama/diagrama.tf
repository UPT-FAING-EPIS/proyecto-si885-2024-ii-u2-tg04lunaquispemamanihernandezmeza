# Azure Cosmos DB Account
resource "azurerm_cosmosdb_account" "cosmosdbaccount1" {
  name                      = var.cosmosdb_account_name
  location                  = var.cosmosdb_account_location
  resource_group_name       = var.resource_group_name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

# Cosmos DB SQL Database
resource "azurerm_cosmosdb_sql_database" "cosmossqldb1" {
  name                = var.cosmosdb_sqldb_name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  autoscale_settings {
    max_throughput = var.max_throughput
  }
}

# Cosmos DB SQL Container
resource "azurerm_cosmosdb_sql_container" "sqlcontainer1" {
  name                  = var.sql_container_name
  resource_group_name   = var.resource_group_name
  account_name          = var.cosmosdb_account_name
  database_name         = var.cosmosdb_sqldb_name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  autoscale_settings {
    max_throughput = var.max_throughput
  }

  indexing_policy {
    indexing_mode = "consistent"
    included_path {
      path = "/*"
    }
    included_path {
      path = "/included/?"
    }
    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}

# Storage Account (Blob Storage)
resource "azurerm_storage_account" "blobstorage1" {
  name                     = "safa1dev"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Azure Service Plan
resource "azurerm_service_plan" "asp1" {
  name                = "asp-fa-tech-com-dev"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

# Windows Function App
resource "azurerm_windows_function_app" "functionapp1" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.asp1.id
  storage_account_name       = azurerm_storage_account.blobstorage1.name
  storage_account_access_key = azurerm_storage_account.blobstorage1.primary_access_key

  site_config {
    # Configuración del sitio
  }

  app_settings = {
    "Google_URL"               = "www.google.com"
    "Cosmos_Connection_String" = var.cosmosdb_connectionstring
  }
}
