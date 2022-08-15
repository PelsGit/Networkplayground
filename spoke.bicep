param location string

module spokeVnet 'Templates/vnet.bicep' = {
  name: '${deployment().name}-spokeDeploy'
  params: {
    addressPrefix: '192.168.0.0/16'
    azureFirewalSubbnetPrefix: '192.168.1.0/26'
    defaultSubnetPrefix: '192.168.2.0/24'
    gatewaySubnetPrefix: '192.168.3.0/26'
    location: location
    subnetPrefix1: '192.168.4.0/24'
    vnetName: 'spoke01'
  }
}
