param location string = 'west europe'

module hubDeployment 'hub.bicep' = {
  name: '${deployment().name}-hubDeploy'
  params: {
    location: location
  }
}

module onPremDeployment 'onprem.bicep' = {
  name: '${deployment().name}-onPremDeploy'
  params: {
    location: location
  }
}

module spokeDeployment 'spoke.bicep' = {
  name: '${deployment().name}-spokeDeploy'
  params: {
    location: location
  }
}

module vnetPeerings 'templates/vnetpeerings.bicep' = {
  name: '${deployment().name}-vnetPeeringsDeploy'
  dependsOn: [
    hubDeployment
    spokeDeployment
  ]
  params: {
    remoteVnetNameHub: 'vnetGwHub'
    remoteVnetNameSpoke: 'spoke01'
  }
}

module vpnConnections 'templates/vpnconnections.bicep' = {
  name: '${deployment().name}-vpnConnectionsDeploy'
  params: {
    hubBgpAsn: 65015
    hubBgpPeeringAddress: hubDeployment.outputs.bgpPeeringAddress
    hubGatewayID: onPremDeployment.outputs.gatewayId
    hubGatewayPublicIP: onPremDeployment.outputs.publicIpAddress
    hubLocalGatewayName: 'hubLocalGateway'
    location: location
    onPremBgpAsn: 65020
    onPremBgpPeeringAddress: onPremDeployment.outputs.bgpPeeringAddress
    onPremGatewayId: hubDeployment.outputs.gatewayId
    onPremGatewayPublicIP: hubDeployment.outputs.publicIpAddress
    onPremLocalGatewayName: 'onPremLocalGateway'
    sharedKey: 'psk'
  }
}
