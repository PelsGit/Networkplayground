param gatewayName string
param subnetReference string
param asn string
param publicIP string

resource Gateway 'Microsoft.Network/virtualNetworkGateways@2022-01-01' = {
  name: gatewayName
  properties: {
    gatewayType: 'Vpn'
    ipConfigurations: [
      {
        name: 'default'
        properties:{
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP
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
