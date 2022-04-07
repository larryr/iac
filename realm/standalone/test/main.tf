variable "apps" {
  type = map(any)
  default = {
    "foo" = {
      "region" = "us-east-1",
    },
    "bar" = {
      "region" = "eu-west-1",
    },
    "baz" = {
      "region" = "ap-south-1",
    },
  }
}

/*
resource "random_pet" "example" {
  for_each = var.apps
}
*/

variable  "peerings" {
  type = list
  default = [
    {
      vnetName = "net0"
      vnetId   = 0
    },
    {
      vnetName = "net1"
      vnetId   = 1
    }
  ]
}

locals {
  peerslist = [
    for idx, peer1 in var.peerings :[
      for peer2 in setsubtract(var.peerings, [{ vnetName = peer1.vnetName, vnetId = peer1.vnetId }]) :
      {
        netName     = peer1.vnetName
        remoteNetId = peer2.vnetId
      }
    ]
  ]

  peers = {
  for idx, p in local.peerslist :
  idx => p[0]
  }

}

resource "random_pet" "cfg" {
  for_each = local.peers

  prefix = each.value.netName
  length = each.value.remoteNetId
}