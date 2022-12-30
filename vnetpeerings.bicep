
param remoteVnetNameSpoke string
param remoteVnetNameHub string

module vnetPeeringtoSpoke 'Templates/vnetpeering.bicep' = {
  name: '${deployment().name}-peeringDeploytoSpoke'
  params: {
    deployVnetPeering: true
    remoteVnet: resourceId('Microsoft.Network/VirtualNetworks',remoteVnetNameSpoke)
    useRemoteGateways: false
    vnetPeeringName: 'vnetGwHub/peeringToSpoke'
    allowGatewayTransit: true
  }
}

module vnetPeeringToHub 'Templates/vnetpeering.bicep' = {
  name: '${deployment().name}-peeringDeployToHub'
  params: {
    deployVnetPeering: true
    remoteVnet: resourceId('Microsoft.Network/VirtualNetworks',remoteVnetNameHub)
    useRemoteGateways: true
    vnetPeeringName: 'spoke01/peeringToHub'
    allowGatewayTransit: true
  }
}
