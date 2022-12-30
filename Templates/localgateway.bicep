param localGatewayName string
param asnNumber int
param bgpPeeringAddress string
param gatewayIpAddress string
param location string
param connectionName string
param vpnGatewayId string
@secure()
param sharedKey string

resource localGateway 'Microsoft.Network/localNetworkGateways@2022-01-01' = {
  name: localGatewayName
  location: location
  properties: {
    bgpSettings: {
      asn: asnNumber
      bgpPeeringAddress: bgpPeeringAddress
    }
    gatewayIpAddress: gatewayIpAddress
  }
}

resource connection 'Microsoft.Network/connections@2020-07-01' = {
  name: connectionName
  location: location
  properties: {
    connectionType: 'IPsec'
    enableBgp: true
    sharedKey: sharedKey    
    virtualNetworkGateway1: {
      id: vpnGatewayId
      properties: {}
    }
    localNetworkGateway2: {
      id: localGateway.id
      properties: {}
    }
  }
}
