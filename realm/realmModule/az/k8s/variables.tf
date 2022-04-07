variable rgName {
    type = string
}

variable location {
    type = string
}

variable realmName {
    description = "name of realm to run in"
    type = string
}

variable nodecount {
    type = number
}

variable nodevmsize {
    type = string
    default = "Standard_D2_v2"
}

variable sshpub {
    type = string
}

variable registry {
    description = "container regisry name and resource group"
    type = object({
      name    = string
      rgName  = string
    })
}

variable realmNet {
    description = "the network information of the realm"
    type        = object ({
            vnetId = string
            vnetName = string
            subnets  = map(
                object({
                    id   = string
                    cidr = list(string)
                })
            )
            rsrv_aks_svc_cidr = string
        })
}
