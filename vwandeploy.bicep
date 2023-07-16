param location string = 'west europe'
param vwanName string = 'vwan'
@secure()
param sharedKey string

module vwan 'Templates/vwan.bicep' = {
  name: '${deployment().name}-vnetDeployhub'
  params: {
    location: location
    vwanName: vwanName
  }
}

module vwanHub 'Templates/vwanhub.bicep' = {
  name: '${deployment().name}-vwanWestEuropeDeploy'
  params: {
    ipPrefix: '192.168.0.0/24'
    location: location
    remoteVwan: vwanName
    virtualHubName: 'westeurope'
  }
}

module vpnSite 'Templates/vpngateway.bicep' = {
  name: '${deployment().name}-vpnGatewayDeploy'
  params: {
    location: location
    parentHub: vwanHub
    vpnGatewayAsn: 65515
    vpnGatewayName: 'gweu'
    remoteVpnGatewaypip: 
    vpnSiteBgpPeeringAddress: 
    vpnSiteLink: 
    vpnSiteName: 
    vwanName: 
    vpnSiteAsnAddress: 65520
  }
}

module onPrem 'onprem.bicep' = {
  name: '${deployment().name}-onPremDeploy'
  params: {
    location: location
  }
}

module localGateway 'Templates/localgateway.bicep' = {
  name: '${deployment().name}-onPremDeploy'
  params: {
    asnNumber: vpnSite.outputs.vpnGatewayAsn
    bgpPeeringAddress: vpnSite.outputs.vpnGatewayPeeringAddress
    connectionName: 'contovwan'
    gatewayIpAddress: vpnSite.outputs.vpnGatewayPip
    localGatewayName: 'lgw'
    location: location
    sharedKey: sharedKey
    vpnGatewayId: vpnSite.outputs.vpnGatewayId
  }
}
