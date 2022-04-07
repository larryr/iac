variable federation {
  type = string
}

variable peerings {
  description = "provide list of networks to peer"
  type = list(object({
      vnetRGname   = string
      vnetName     = string
      peerIds      = list(string)
  }))
}

