param buildNumber string
param appName string
param environmentName string
param location string = resourceGroup().location
param containerImage string
param sqlServerLocation string
param databaseServerName string
param databaseName string
param databaseUserName string
@secure()
param databasePassword string
var aciName = 'aci-${appName}-${environmentName}'

module database 'sqlserver/template.bicep' = {
  name: '${buildNumber}-database-setup'
  params: {
    location: sqlServerLocation
    serverName: databaseServerName
    databaseName: databaseName
    adminUserName: databaseUserName
    adminPassword: databasePassword
  }
}

module containerInstance 'aci/template.bicep' = {
  name: '${buildNumber}-container-instance'
  params: {
    location: location
    name: aciName
    databaseServerName: database.outputs.serverName
    databaseName: databaseName
    databaseUserName: databaseUserName
    databasePassword: databasePassword
    image: containerImage
  }
  dependsOn: [
    database
  ]
}
