param virtualHubName string
param location string
param ipPrefix string
param remoteVwan string

resource vwanhub 'Microsoft.Network/virtualHubs@2022-07-01' = {
  name: virtualHubName
  location: location
  properties: {
    addressPrefix: ipPrefix
    allowBranchToBranchTraffic: true
    virtualWan: {
      id: remoteVwan
    }
    sku: 'Standard'
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
    }
  }
}

output vwanHubName string = vwanhub.name

resource vwanHubRoutingIntent 'Microsoft.Network/virtualHubs/routingIntent@2023-04-01' = {
  name: 'string'
  parent: vwanhub
  properties: {
    routingPolicies: [
      {
        destinations: [
          'Internet'
          'PrivateTraffic'
        ]
        name: 'string'
        nextHop: 'string'
      }
    ]
  }
}
