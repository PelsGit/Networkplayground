param location string

module vnetOnPrem 'Templates/vnet.bicep' = {
  name: '${deployment().name}-vnetDeployonprem'
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
    location: location
    asn: 65020
    gatewayName: 'gatewayOP'
    publicIpName: 'pipGWOP'
    subnetReference: vnetOnPrem.outputs.gatewaySubnetID
  }
}

output bgpPeeringAddress string = gatewayOnPrem.outputs.bgpPeeringAddress
output publicIpAddress string = gatewayOnPrem.outputs.publicIpAddress
output gatewayId string = gatewayOnPrem.outputs.gatewayId
