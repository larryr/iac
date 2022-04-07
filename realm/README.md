# realm

A *realm* is a complete high availbility and resilent environment for deploying services to.

A *realm* exists within a *federation* of other *realms*.  

Each *realm* is a set of resources with minimum dependency on another *realm*. The only dependency is an expectation of connectivity between *realm* and the *federation*. In this manner a *realm* agrees to have network reachability across the federations.  This implies a compatible federation-wide addressing scheme and ability to route packets between any member of one realm to any member of another realm (within policies).

## Federation within Azure
To be more specific a *realm* on azure will assume the following:

- federation 
  - Part of one account
  - contains a contiguous network address space allowing routing throughout the 
  federation
    - federation wide Private DNS (with upstream to public DNS)
    - federation wide routing tables for network routing between realms
  - a federation wide resource group exists (with realm resource groups)
- real resources exist in one cloud region
  - has it's own resource group that is a member of the federation resource group
  - has it's own vnet
  - has a well defined set of standard sub-nets (may support additonal specific subnets that don't clash with standard sub-nets)
  - spans availability zones
  - contains it's own egress/ingress from internet/external networks

# Federation Realms

Federation supports 32 realms.  
Realm limits
- 65k addresses total per realm (limit of addresses per vnet)
- 1 vnet/realm
- /13 address space per realm
- 6 resererved /16 address spaces per realm
- 2 unreserved /16 address spaces per realm


## realm standard resources
Support
- vnet (/13)
  - 10.{0..31}[subnet].0.0/13
- subnets (/16)
  - well known names
  - same address space/vnet
  - 10.[vnet]{0..7}.0.0/16
  - subnets
    - 0: ctl    -- k8s control plane
    - 1: nodes  -- k8s nodes
    - 2: srv    -- VMs
    - 3: svc    -- managed services
    - 4: sys    -- net services
    - 5: dmz    -- outside of realm protection
    - 6,7       -- unassigned per/realm resources

# Configuration

- Create necessary common modules in `realmModule`
- modify root .tf as necessary
- modify realms.tf to configure a new realm using `realmModule` modules.

# Provisioning

- realmnet
  - cd realmnet
  - terraform apply
- jump servers

# Interaction between Federations
More than one federations can interact via a common *access network*.  The *access network* will be a unique private network which each federatinon will access via NAT (receiving 1+ *access network* addresses as necessary).  