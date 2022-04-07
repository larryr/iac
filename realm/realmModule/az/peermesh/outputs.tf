output peerslist {
  value = local.peerslist
}

output peers {
  value = local.peers
}

output peering {
  value = azurerm_virtual_network_peering.peering
}

