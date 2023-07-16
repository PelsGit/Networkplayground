param vpnGatewayName string
param location string
param vpnSiteName string
param vpnSiteLink string
param vpnSiteBgpPeeringAddress string
param remoteVpnGatewaypip string
param vwanName  string
param vpnSiteAsnAddress int 
param parentHub string
param vpnGatewayAsn int

resource vpnSite 'Microsoft.Network/vpnSites@2020-05-01' = {
  name: vpnSiteName
  location: location
  properties: {
    deviceProperties: {
      deviceVendor: 'Microsoft'
      deviceModel: 'AzureVPNGateway'
      linkSpeedInMbps: 500
    }
    vpnSiteLinks: [
      {
        name: vpnSiteLink
        properties: {
          bgpProperties: {
            asn: vpnSiteAsnAddress
            bgpPeeringAddress: vpnSiteBgpPeeringAddress
          }
          linkProperties: {
            linkProviderName: 'Azure'
            linkSpeedInMbps: 500
          }
          ipAddress: remoteVpnGatewaypip
        }
      }
    ]
    virtualWan: {
      id: vwanName
    }
  }
}

resource vpnGateway 'Microsoft.Network/vpnGateways@2021-03-01' = {
  name: vpnGatewayName
  location: location
  properties: {
    vpnGatewayScaleUnit: 1
    virtualHub: {
      id: parentHub
    }
    bgpSettings: {
      asn: vpnGatewayAsn
    }
  }
}

output vpnGatewayPeeringAddress string = vpnGateway.properties.bgpSettings.bgpPeeringAddress
output vpnGatewayAsn int = vpnGateway.properties.bgpSettings.asn
output vpnGatewayPip string = vpnGateway.properties.ipConfigurations[0].publicIpAddress
output vpnGatewayId string = vpnGateway.id
