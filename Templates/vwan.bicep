param vwanName string
param location string

resource virtualWan 'Microsoft.Network/virtualWans@2022-11-01' = {
  name: vwanName
  location: location
  properties: {
    type: 'Standard'
  }
}

output virtualWanName string = virtualWan.name
