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
