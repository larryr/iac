
# identify the container registry for cluster to use
data "azurerm_container_registry" "acr" {
    name                = var.registry.name
    resource_group_name = var.registry.rgName
}

# setup a role so the cluster kubelets can pull containers
resource "azurerm_role_assignment" "role_acrpull" {
    scope                            = data.azurerm_container_registry.acr.id
    role_definition_name             = "AcrPull"
    principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity.0.object_id
    skip_service_principal_aad_check = true
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                         = local.clusterName
    location                     = var.location
    resource_group_name          = var.rgName
    sku_tier                     = "Free"

    #kubernetes_version
    #private_cluster_enabled = false
    #maintenance_window {}

    identity {
        type = "SystemAssigned"
        #user_assigned_identity_id
    }
    #service_principal {}
    role_based_access_control {
        enabled = true
    }

    #kubelet_identity {             #preview
        #client_id
        #object_id
        #user_assigned_identity_id
    #}

 
    ## nodes

    #automatic_channel_upgrade = none  #patch,rapid,node-image,stable  #preview

    #node_resource_group 

    linux_profile {
        admin_username = "larry"

        ssh_key {
            key_data = file(var.sshpub)
        }
    }

    default_node_pool {
        name                = "nodepool"
        type                = "VirtualMachineScaleSets"
        vm_size             = var.nodevmsize
        max_pods            = 200
        enable_auto_scaling = true
        node_count          = var.nodecount
        min_count           = var.nodecount
        max_count           = 100 + var.nodecount
        availability_zones  = ["1", "2", "3"]

        os_sku              = "Ubuntu"
        #os_disk_type
        os_disk_size_gb     = "256"

        #tags
        #node_labels
        #enable_host_encryption
        #enable_node_public_ip = false
        #node_public_ip_prefix_id
        kubelet_config {
           #allowed_unsafe_sysctls
           #container_log_max_line
           #container_log_max_size_mb
           #cpu_cfs_quota_enabled
           #cpu_cfs_quota_period
           #cpu_manager_policy
           image_gc_high_threshold = 80
           image_gc_low_threshold  = 10
           #pod_max_pid     
           #topology_manager_policy
        }
        #linux_os_config {
            #swap_file_size_mb
            #sysctl_config {}
            #transparent_huge_page_enabled
            #transparent_huge_page_defrag
        #}
        #fips_enabled                   #preview
        #kublet_disk_type
        #only_critical_addons_enabled
        #orchestrator_version
        vnet_subnet_id = var.realmNet.subnets["${var.realmName}.subnet-nodes"].id
        pod_subnet_id  = var.realmNet.subnets["${var.realmName}.subnet-pods"].id
        #ultra_ssd_enabled
        #updgrade_settings {}

    }

    #auto_scaler_profile {}
    #desk_encryption_set_id
    #linux_profile {
        #admin_username
        #ssh_key
    #}
    #local_account_disabled = false


    ## networking

    dns_prefix                           = "k8s" #local.clusterName
    #dns_prefix_private_cluster
    #private_dns_zone_id 
    #private_cluster_public_fqdn_enabled = false  #preview
    #public_network_access_enabled       = true
    network_profile {
        load_balancer_sku  = "Standard"
        network_plugin     = "azure"
        network_policy     = "azure"
        docker_bridge_cidr = "172.17.0.1/16"  #this is default; this is good.
        service_cidr       = var.realmNet.rsrv_aks_svc_cidr
        dns_service_ip     = cidrhost(var.realmNet.rsrv_aks_svc_cidr, 10)
        #network_mode
        #outbound_type
        #dns_service_ip
        #pod_cidr  #not used for azure
        #load_balancer_sku
        #load_balancer_profile {
            #outbound_ports_allocated = 20000
            #idle_timeout_in_minutes  = 10
            #managed_outbound_ip_count 
            #outbound_ip_prefix_ids
            #outbound_ip_address_ids
        #}
        #nat_gateway_profile {
            #idle_timeout_in_minutes
            #managed_outbound_ip_count
        #}
    }
    #api_server_authorized_ip_ranges
    #http_proxy_config {}                 #preview

    ## cluster info
    tags = {
        Environment = var.realmName
    }


    ## AKS Addons

   #addon_profile {
    #  azure_policy{}
    #  http_application_routing {}
    #  kube_dashboard {}
    #  oms_agent {
        #enabled
        #log_analytics_workspace_id
    #}
    #  ingress_application_gateway
    #  open_service_mesh {                   #preview
        #enabled
    #}
    #  azure_keyvault_secrets_provider{
        #enabled
        #secret_rotation_enabled
        #secret_rotation_interval
    #}
    #}

}