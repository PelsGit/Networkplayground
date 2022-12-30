param location string
@secure()
param sharedKey string

//OnPrem parameters
param onPremGatewayId string
param onPremBgpAsn int
param onPremBgpPeeringAddress string
param hubGatewayPublicIP string
param hubLocalGatewayName string

//Hub parameters
param hubGatewayID string
param hubBgpAsn int
param hubBgpPeeringAddress string
param onPremGatewayPublicIP string 
param onPremLocalGatewayName string 

module connectionToOnPrem 'Templates/localgateway.bicep' = {
  name: '${deployment().name}-connectionToOnPrem'
  params: {
    asnNumber: onPremBgpAsn
    bgpPeeringAddress: onPremBgpPeeringAddress
    connectionName: 'connectionToOnprem'
    gatewayIpAddress: hubGatewayPublicIP
    localGatewayName: hubLocalGatewayName
    location: location
    sharedKey: sharedKey
    vpnGatewayId: onPremGatewayId
  }
}

module connectionToHub 'Templates/localgateway.bicep' = {
  name: '${deployment().name}-connectionToHub'
  params: {
    asnNumber: hubBgpAsn
    bgpPeeringAddress: hubBgpPeeringAddress
    connectionName: 'connectionToHub'
    gatewayIpAddress: onPremGatewayPublicIP
    localGatewayName: onPremLocalGatewayName
    location: location
    sharedKey: sharedKey
    vpnGatewayId: hubGatewayID
  }
}
