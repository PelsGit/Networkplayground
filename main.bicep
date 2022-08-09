param location string = 'west europe'

module hubDeployment 'hub.bicep' = {
  name: '${deployment().name}-hubDeploy'
  params: {
    location: location
  }
}

module onPremDeployment 'onprem.bicep' = {
  name: '${deployment().name}-onPremDeploy'
  params: {
    location: location
  }
}
