param location string = 'west europe'

module vnetOnPrem 'Templates/vnet.bicep' = {
  name: '${deployment().name}-vnetDeploy'
  params: {
    addressPrefix: '10.1.0.0/16'
    location: location
    defaultSubnetPrefix: '10.1.1.0/24'
    gatewaySubnetPrefix: '10.1.2.0/27'
    subnetPrefix1: '10.1.3.0/24'
    vnetName: 'vnetonprem'
    azureFirewalSubbnetPrefix:'10.1.2.128/27'
  }
}

module gatewayOnPrem 'Templates/gateway.bicep'= {
  name: '${deployment().name}-gatewayDeploy'
  params: {
    asn: 65020
    gatewayName: 'gatewayOP'
    publicIpName: 'pipGWOP'
    subnetReference: vnetOnPrem.outputs.gatewaySubnetID
  }
}
