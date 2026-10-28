// Approved template: one Linux VM with mandatory tags (illustrative for the demo).
@allowed(['westeurope', 'northeurope', 'francecentral'])
param location string
@allowed(['Standard_B2s', 'Standard_D2s_v5', 'Standard_D4s_v5'])
param vmSize string = 'Standard_B2s'
param vmName string
param costCenter string
param appId string
@allowed(['dev', 'test', 'prod'])
param environment string
param subnetId string
param adminUsername string = 'platformadmin'
@secure()
param sshPublicKey string

var tags = {
  CostCenter: costCenter
  AppId: appId
  Environment: environment
  ManagedBy: 'pipeline'
}

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: '${vmName}-nic'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: { id: subnetId }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: location
  tags: tags
  properties: {
    hardwareProfile: { vmSize: vmSize }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: { publicKeys: [ { path: '/home/${adminUsername}/.ssh/authorized_keys', keyData: sshPublicKey } ] }
      }
    }
    storageProfile: {
      imageReference: { publisher: 'Canonical', offer: '0001-com-ubuntu-server-jammy', sku: '22_04-lts-gen2', version: 'latest' }
      osDisk: { createOption: 'FromImage', managedDisk: { storageAccountType: 'StandardSSD_LRS' } }
    }
    networkProfile: { networkInterfaces: [ { id: nic.id } ] }
  }
}
