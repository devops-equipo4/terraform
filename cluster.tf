

resource "azurerm_kubernetes_cluster" "g4s3" {
  name                = "g4s3-aks1"
  location            = azurerm_resource_group.g4s3.location
  resource_group_name = azurerm_resource_group.g4s3.name
  dns_prefix          = "g4s3aks1"
  kubernetes_version  = "1.19.6"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2ads_v5"
    enable_auto_scaling = true
    max_count  = 3
    min_count  = 1
    max_pods   = 80
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }

  network_profile {
      network_plugin = "azure"
      network_policy = "azure"
  } 
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.g4s3.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.g4s3.kube_config_raw

  sensitive = true
}

