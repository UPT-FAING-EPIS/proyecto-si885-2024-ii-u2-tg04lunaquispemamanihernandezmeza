# Terraform para Configurar Cosmos DB en Azure

Este repositorio utiliza **Terraform** para crear y gestionar una infraestructura en **Microsoft Azure** que incluye los siguientes recursos:

- **Grupo de Recursos**: Agrupa todos los recursos de Azure relacionados.
- **Cuenta de Cosmos DB**: Crea una cuenta de Cosmos DB con almacenamiento analítico habilitado.
- **Base de Datos SQL en Cosmos DB**: Configura una base de datos SQL dentro de la cuenta de Cosmos DB.
- **Contenedor SQL en Cosmos DB**: Crea un contenedor SQL con clave de partición y rendimiento configurado.
- **Asignación de Roles**: Asigna permisos de acceso a un principal (usuario o aplicación) para realizar operaciones CRUD en Cosmos DB.

## Variables de Configuración

- **location**: Ubicación de los recursos (por ejemplo, "East US").
- **resource_group_name**: Nombre del grupo de recursos.
- **cosmosdb_account_name**: Nombre de la cuenta de Cosmos DB.
- **cosmosdb_database_name**: Nombre de la base de datos en Cosmos DB.
- **cosmosdb_container_name**: Nombre del contenedor en Cosmos DB.
- **partition_key_path**: Ruta de la clave de partición.
- **throughput**: Rendimiento del contenedor de Cosmos DB (por ejemplo, 400).

## Requisitos

- **Terraform**: Para ejecutar estos scripts.
- **Cuenta de Azure**: Con permisos adecuados para crear recursos.

## Cómo Ejecutar

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu_usuario/tu_repositorio.git
   cd tu_repositorio


