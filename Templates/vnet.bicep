param vnetname string
param location string
param addressPrefix string
param defaultsubnetprefix string
param SubnetPrefix1 string
param GatewaySubnetPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: vnetname
  location: location
  extendedLocation: {
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    enableDdosProtection: false
    enableVmProtection: false
    subnets: [
      {
        name: 'DefaultSubnet'
        properties: {
          addressPrefix: defaultsubnetprefix
        }
      }
      {
        name: 'Subnet1'
        properties: {
          addressPrefix: SubnetPrefix1
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: GatewaySubnetPrefix
        }
      }
    ]
  }
}
