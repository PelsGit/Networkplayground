param hubConName string
param virtualNetworkID string
param routeTable string
param remoteHubName string

resource hubtospoke 'Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2020-05-01' = {
  name: hubConName
  properties: {
    routingConfiguration: {
      associatedRouteTable: {
        id: routeTable
      }
      propagatedRouteTables: {
        labels: [
          'none'
        ]
        ids: [
          {
            id: resourceId('Microsoft.Network/virtualHubs/hubRouteTables', remoteHubName, 'noneRouteTable')
          }
        ]
      }
    }
    remoteVirtualNetwork: {
      id: virtualNetworkID
    }
    allowHubToRemoteVnetTransit: true
    allowRemoteVnetToUseHubVnetGateways: true
    enableInternetSecurity: true
  }
}
