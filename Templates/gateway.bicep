param gatewayName string
param subnetReference string
param asn int
param publicIpName string
param location string


resource Gateway 'Microsoft.Network/virtualNetworkGateways@2022-01-01' = {
  name: gatewayName
  location: location
  properties: {
    gatewayType: 'Vpn'
    ipConfigurations: [
      {
        name: 'default'
        properties:{
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id:subnetReference
          }
        }
      }
    ]
    enableBgp: true 
    bgpSettings: {
      asn: asn
    }
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2021-03-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    idleTimeoutInMinutes: 4
  }
}

output bgpPeeringAddress string = Gateway.properties.bgpSettings.bgpPeeringAddress
output publicIpAddress string = publicIp.properties.ipAddress
output gatewayId string = Gateway.id
