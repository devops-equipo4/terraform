# terraform

- Error de regiones, no permite usar la versión requerida de kubernetes (1.19.6) en las regiones probadas: westus, eastus2, centralus
- Error de regiones, no acepta los tamaños (SKU) probados en ninguna de las regiones.

Se utilizó el provider facilitado en la clase, no fue posible registrar el tier gratuito de Azure, por lo cual no podíamos acceder a revisar los recursos disponibles en la cuenta, o rescatar las key para realizar conexione a la máquina creada


```
Error: creating Cluster: (Managed Cluster Name "g4s3-aks1" / Resource Group "g4s3-resources_2"): containerservice.ManagedClustersClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="AgentPoolK8sVersionNotSupported" Message="Version 1.19.6 is not supported in this region. Please use [az aks get-versions] command to get the supported version list in this region. For more information, please check https://aka.ms/supported-version-list
```
```
Error: creating Network Interface: (Name "g4s3-nic" / Resource Group "g4s3-resources_2"): network.InterfacesClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: autorest/azure: Service returned an error. Status=<nil> Code="InvalidResourceLocation" Message="The resource 'g4s3-nic' already exists in location 'westus' in resource group 'g4s3-resources_2'. A resource with the same name cannot be created in location 'centralus'. Please select a new resource name."
```
