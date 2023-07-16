param vwanHubConName string
param vwanHubName string
param virtualNetworkId string

resource vwanhub 'Microsoft.Network/virtualHubs@2022-07-01' existing = {
  name: vwanHubName
}

resource vwanHubConnection 'Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2020-05-01' = {
  name: vwanHubConName
  parent: vwanhub
  properties: {
    routingConfiguration: {
      associatedRouteTable: {
        id: resourceId('Microsoft.Network/virtualHubs/hubRouteTables', vwanHubName, 'defaultRouteTable')
      }
      propagatedRouteTables: {
        labels: [
          'default'
        ]
        ids: [
          {
            id: resourceId('Microsoft.Network/virtualHubs/hubRouteTables', vwanHubName, 'defaultRouteTable')
          }
        ]
      }
    }
    remoteVirtualNetwork: {
      id: virtualNetworkId
    }
    enableInternetSecurity: true
  }
}
