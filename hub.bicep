param location string = 'west europe'

module vnetGwHub 'Templates/vnet.bicep'= {
  name: '${deployment().name}-vnetDeploy'
  params: {
    addressPrefix: '172.16.0.0/16'
    location: location
    defaultSubnetPrefix: '172.16.1.0/24'
    gatewaySubnetPrefix: '172.16.2.0/27'
    subnetPrefix1: '172.16.3.0/24'
    vnetName: 'vnetGwHub'
    azureFirewalSubbnetPrefix:'172.16.2.128/27'
  }
}

module gatewayHub 'Templates/gateway.bicep'= {
  name: '${deployment().name}-gatewayDeploy'
  params: {
    asn: 65020
    gatewayName: 'gatewayOP'
    publicIpName: 'pipGWOP'
    subnetReference: vnetGwHub.outputs.gatewaySubnetID
  }
}
