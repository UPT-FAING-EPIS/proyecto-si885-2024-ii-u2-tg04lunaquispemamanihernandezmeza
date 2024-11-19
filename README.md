[![Open in Codespaces](https://classroom.github.com/assets/launch-codespace-2972f46106e565e64193e422d61a12cf1da4916b45550586e14ef0a7c637dd04.svg)](https://classroom.github.com/open-in-codespaces?assignment_repo_id=15560313)
# proyecto-formatos-01
# Despliegue de infraestructura en Azure con Terraform

Este proyecto configura los siguientes recursos en Azure utilizando Terraform:

- **Grupo de recursos** llamado `topicos_grupo_MAJEC_rg`.
- **Red virtual** llamada `topicos_grupo_MAJEC_vnet` con un espacio de direcciones `10.0.0.0/16`.
- **Subred** llamada `topicos_grupo_MAJEC_subnet` con el prefijo de direcciones `10.0.1.0/24`.
- **Interfaz de red** llamada `topicos_grupo_MAJEC_nic`.
- **Máquina virtual Linux** llamada `topicos_grupo_MAJEC_vm`, configurada con Ubuntu Server 18.04-LTS y autenticación SSH.

## Información de la máquina virtual

Se ha creado una máquina virtual en Azure con los siguientes detalles:

| **Nombre de la VM**        | **Grupo de recursos**     | **Ubicación** | **Tamaño**        | **Disco del sistema operativo**  | **Dirección IP pública** |
|----------------------------|---------------------------|---------------|-------------------|---------------------------------|--------------------------|
| topicos_grupo_MAJEC_vm      | topicos_grupo_MAJEC_rg    | East US       | Standard_B1ls     | /subscriptions/.../osdisk       | 20.45.10.10              |

## Requisitos

- Terraform
- Cuenta de Azure con los permisos adecuados
- Clave SSH pública en la ruta `C:/Users/PC/.ssh/id_rsa.pub`

## Pasos

1. Clona este repositorio.
2. Define tus variables de Azure en el archivo `terraform.tfvars`.
3. Inicializa Terraform:
    ```bash
    terraform init
    ```
4. Verifica el plan de ejecución:
    ```bash
    terraform plan
    ```
5. Aplica el plan para crear los recursos:
    ```bash
    terraform apply
    ```
Los recursos se crearán en el grupo de recursos de Azure en la región **East US**.

