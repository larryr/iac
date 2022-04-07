
locals {
  # create a single list of all peer pairs; each peer points to other peer, not to self.
  peerslist = flatten([
    for peer1 in var.peerings : [
      for peer2 in peer1.peerIds:
        {
          netRGname   = peer1.vnetRGname
          netName     = peer1.vnetName
          remoteNetId = peer2
        }
    ]
  ])

  # turn list into a map to process in for_each
  peers = {
    for idx, p in local.peerslist :
      idx => p
  }

}

# setup global peering -- peer's across regions
resource "azurerm_virtual_network_peering" "peering" {
  for_each = local.peers
  #local.peers

  name                      = "${var.federation}-peers-${each.value.netName}-${each.key}"
  resource_group_name       = each.value.netRGname
  virtual_network_name      = each.value.netName
  remote_virtual_network_id = each.value.remoteNetId
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false    #must be false for global peering
}

