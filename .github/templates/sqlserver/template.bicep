
@description('Location for all resources.')
param location string = resourceGroup().location

@description('The name of the SQL logical server.')
param serverName string

@description('The name of the SQL Database.')
param databaseName string

@description('The administrator username of the SQL logical server.')
param adminUserName string

@description('The administrator password of the SQL logical server.')
@secure()
param adminPassword string

resource sqlServer 'Microsoft.Sql/servers@2020-02-02-preview' = {
  name: serverName
  location: location
  identity:{
    type:'SystemAssigned'
  }
  properties: {
    administratorLogin: adminUserName
    administratorLoginPassword: adminPassword
    minimalTlsVersion:'1.2'
    publicNetworkAccess:'Enabled'        
  }  
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: sqlServer
  name: databaseName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 1073741824
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
  }
}

resource allowedWindowsAzureIps 'Microsoft.Sql/servers/firewallRules@2020-02-02-preview' = {
  parent: sqlServer
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource connectionPolicies 'Microsoft.Sql/servers/connectionPolicies@2021-11-01-preview' = {
  name: 'default'
  parent: sqlServer
  properties: {
    connectionType: 'Redirect'
  }
  dependsOn: [
    sqlDatabase
  ]
}

output serverName string = 'tcp:${sqlServer.properties.fullyQualifiedDomainName}'
