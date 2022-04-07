variable rgName {
  type = string
}

variable location {
  type = string
}

variable vnet_id {
  description = "ID of the VNET where jumpsrv VM will be installed"
  type        = string
}

variable subnet_id {
  description = "ID of subnet where jumpsrv VM will be installed"
  type        = string
}

variable dns_zone_name {
  description = "Private DNS Zone name to link jumpsrv's vnet to"
  type        = string
}

variable sshpub {
  type = string
}