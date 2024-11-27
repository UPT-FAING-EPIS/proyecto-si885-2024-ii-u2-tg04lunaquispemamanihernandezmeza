resources:
  - name: "Resource Group"
    type: "azure.ResourceGroup"
    location: "East US"
    properties:
      name: "${var.resource_group_name}"

  - name: "Cosmos DB Account"
    type: "azure.CosmosDBAccount"
    location: "East US"
    properties:
      name: "${var.cosmosdb_account_name}"
      offer_type: "Standard"
      kind: "GlobalDocumentDB"
      consistency_policy:
        consistency_level: "Session"
      geo_location:
        location: "East US"
        failover_priority: 0
      enable_analytical_storage: true

  - name: "Cosmos DB SQL Database"
    type: "azure.CosmosDBSqlDatabase"
    properties:
      name: "${var.cosmosdb_database_name}"
      account_name: "${var.cosmosdb_account_name}"

  - name: "Cosmos DB SQL Container"
    type: "azure.CosmosDBSqlContainer"
    properties:
      name: "${var.cosmosdb_container_name}"
      database_name: "${var.cosmosdb_database_name}"
      partition_key_paths:
        - "${var.partition_key_path}"
      throughput: "${var.throughput}"

  - name: "Role Assignment for Cosmos DB"
    type: "azure.RoleAssignment"
    properties:
      principal_id: "${var.principal_id}"
      role_definition_name: "Cosmos DB Account Reader Role"
      scope: "${var.cosmosdb_account_name}"

  - name: "App Service Plan"
    type: "azure.AppServicePlan"
    properties:
      name: "example-service-plan"
      location: "East US"
      sku:
        tier: "Standard"
        size: "S1"

  - name: "Web App (App Service)"
    type: "azure.AppService"
    properties:
      name: "example-flask-app"
      location: "East US"
      app_service_plan_id: "${azure.AppServicePlan.example.id}"
      app_settings:
        COSMOS_DB_URL: "${azure.CosmosDBAccount.example.document_endpoint}"
        COSMOS_DB_KEY: "${azure.CosmosDBAccount.example.primary_master_key}"
        COSMOS_DB_DATABASE: "${azure.CosmosDBSqlDatabase.example.name}"
        COSMOS_DB_CONTAINER: "${azure.CosmosDBSqlContainer.example.name}"
      site_config:
        linux_fx_version: "PYTHON|3.9"


