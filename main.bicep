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

module vpnConnections 'vpnconnections.bicep' = {
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
