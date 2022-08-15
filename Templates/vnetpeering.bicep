param remoteVnet string
param vnetPeeringName string
param useRemoteGateways bool
param deployVnetPeering bool
param allowGatewayTransit bool

resource vneetPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-01-01' = if(deployVnetPeering) {
  name: vnetPeeringName
  properties: {
    remoteVirtualNetwork: {
      id: remoteVnet
    }
    useRemoteGateways: useRemoteGateways
    allowForwardedTraffic: true
    allowGatewayTransit: allowGatewayTransit
    allowVirtualNetworkAccess: true
  }
}
