@description('Name for the container group')
param name string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Container image to deploy')
param image string

@description('The number of CPU cores to allocate to the container.')
param cpuCores int = 1

@description('The amount of memory to allocate to the container in gigabytes.')
param memoryInGb int = 1

@description('The behavior of Azure runtime if container has stopped.')
@allowed([
  'Always'
  'Never'
  'OnFailure'
])
param restartPolicy string = 'OnFailure'
param databaseServerName string
param databaseName string
param databaseUserName string
@secure()
param databasePassword string

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2021-09-01' = {
  name: name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    containers: [
      {
        name: name
        properties: {
          image: image          
          resources: {
            requests: {
              cpu: cpuCores
              memoryInGB: memoryInGb
            }
          }
          environmentVariables: [     
            {
              name: 'SERVER_NAME'
              value: databaseServerName
            }
            {
              name: 'USERNAME'
              value: databaseUserName
            }            
            {
              name: 'PASSWORD'
              secureValue: databasePassword
            }            
            {
              name: 'DATABASE_NAME'
              value: databaseName
            }        
          ]
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: restartPolicy    
  }
}
