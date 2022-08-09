param vnetName string
param location string
param addressPrefix string
param defaultSubnetPrefix string
param subnetPrefix1 string
param azureFirewalSubbnetPrefix string
param gatewaySubnetPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnetName
  location: location
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
          addressPrefix: defaultSubnetPrefix
        }
      }
      {
        name: 'Subnet1'
        properties: {
          addressPrefix: subnetPrefix1
        }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: gatewaySubnetPrefix
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: azureFirewalSubbnetPrefix
        }
      }
    ]
  }
}

output gatewaySubnetID string = resourceId('Microsoft.Network/VirtualNetworks/subnets',vnetName,'GatewaySubnet')
