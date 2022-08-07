param location string = 'west europe'
module vnetOnPrem 'Templates/vnet.bicep' = {
  name: '${deployment().name}-vnetDeploy'
  params: {
    addressPrefix: '10.1.0.0/16'
    location: location
    defaultsubnetprefix: '10.1.1.0/24'
    GatewaySubnetPrefix: '10.1.2.0/27'
    SubnetPrefix1: '10.1.3.0/24'
    vnetname: 'vnetonprem'
  }
}

module vnetGwHub 'Templates/vnet.bicep'= {
  name: '${deployment().name}-vnetDeploy'
  params: {
    addressPrefix: '172.16.0.0/16'
    location: location
    defaultsubnetprefix: '172.16.1.0/24'
    GatewaySubnetPrefix: '172.16.2.0/27'
    SubnetPrefix1: '172.16.3.0/24'
    vnetname: 'vnetGwHub'
  }
}
