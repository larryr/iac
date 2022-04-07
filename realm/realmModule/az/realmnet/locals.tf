# local variables for realmnet module
locals {
    realmName         = "${var.fedName}-realm-${var.realmID}"
    realmRG           = "${local.realmName}-rg"
    realmVnet         = "${local.realmName}-net"
    realmAddressSpace = cidrsubnet("10.0.0.0/8",5,var.realmID)
    realmSubnets      = tomap({
                            #reserved  = 0  AKS_service_cidr
                            "nodes"    = 1,
                            "pods"     = 2,
                            "srv"      = 3,
                            "svc"      = 4,
                            "sys"      = 5,
                            "dmz"      = 6
                        })
}