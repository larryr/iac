# realm-net

The *realm* network is defined before any other resources are defined and is part of the 
*realm* resource group.

This directory will concern itself with the creations and management of the *realm's* network.

## Realm network
Within a *federation* there are up to 32 possible vnets (0..31).

Each *realm* network (vnet) has the cidr range:

`10.{vnet-id:5}.0.0/13`

i.e. there are 2^5=32 possible vnets in the federation.

there are 7 reserved cidr ranges for subnets within the realm.

6 subnets created are explicitly created and 1 cidr range left reserved.

Each subnet has a cidr created with following pattern:

`10.{vnet-id:5}{subnet-id:3}.0.0/16`

subnets:

- 0 --> reserved but subnet not created
- 1 --> "nodes" intended for k8s nodes (VMs)
- 2 --> "pods"  intended for k8s pods
- 3 --> "srv"   intended for any servers ouside k8s
- 4 --> "svc"   intended for managed service 
- 5 --> "sys"   intended for systems use   ?? mayb not needed
- 6 --> "dmz"   intended for servers that may be firewalled from other subnets

Within a vnet any subnet will route to any other subnet.

## Peering

The intent is all *realms* in a *federation* are peered.  The peering definition
will be defined outside this setup in order to allow for different topologies.

Example peering for a federation with 3 *realms* Each *realm* vnet is peered with the other vnets. e.g.
vnet0 <-> vnet1 <-> vnet2 <-> vnet0

connectivity will route to any system on any vnet.
