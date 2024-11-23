// ./modules/cosmos_account/variables.tf

variable "cosmosdb_account_name" {
  type        = string
  description = "Cosmos DB account name"
}

variable "cosmosdb_account_location" {
  type        = string
  description = "Cosmos DB account location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Resource group location"
}
