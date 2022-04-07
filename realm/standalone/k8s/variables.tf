
variable "ssh_public_key" {
    default = "~/.ssh/realm_rsa.pub"
}

# cluster setup 
variable cluster_name {
    default = "k8s0"
}

variable resource_group_name {
    default = "k8s0-rg"
}

variable location {
    default = "eastus"
}

variable "dns_prefix" {
    default = "k8s0"
}


# cluster node setup
variable "agent_count" {
    default = 5
}

variable "agent_vm" {
    default = "Standard_D2_V2"
}
