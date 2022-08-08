param localGatewayName string
param asnNumber int
param bgpPeeringAddress string
param gatewayIpAddress string

resource localGateway 'Microsoft.Network/localNetworkGateways@2022-01-01' = {
  name: localGatewayName
  properties: {
    bgpSettings: {
      asn: asnNumber
      bgpPeeringAddress: bgpPeeringAddress
    }
    gatewayIpAddress: gatewayIpAddress
  }
}
