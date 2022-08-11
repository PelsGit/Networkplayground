param location string
module vnetGwHub 'Templates/vnet.bicep' = {
  name: '${deployment().name}-vnetDeployhub'
  params: {
    addressPrefix: '172.16.0.0/16'
    location: location
    defaultSubnetPrefix: '172.16.1.0/24'
    gatewaySubnetPrefix: '172.16.2.0/27'
    subnetPrefix1: '172.16.3.0/24'
    vnetName: 'vnetGwHub'
    azureFirewalSubbnetPrefix: '172.16.2.128/27'
  }
}

module gatewayHub 'Templates/gateway.bicep' = {
  name: '${deployment().name}-gatewayDeploy'
  params: {
    location: location
    asn: 65015
    gatewayName: 'gatewayHub'
    publicIpName: 'pipGWHub'
    subnetReference: vnetGwHub.outputs.gatewaySubnetID
  }
}

output bgpPeeringAddress string = gatewayHub.outputs.bgpPeeringAddress
output publicIpAddress string = gatewayHub.outputs.publicIpAddress
output gatewayId string = gatewayHub.outputs.gatewayId
