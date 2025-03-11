param managedClusters_Aks1_name string = 'Aks1'
param workspaces_DefaultWorkspace_09f867a5_6bb2_4dad_ab50_5d7eb653d4f3_SEA_externalid string = '/subscriptions/09f867a5-6bb2-4dad-ab50-5d7eb653d4f3/resourceGroups/DefaultResourceGroup-SEA/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-09f867a5-6bb2-4dad-ab50-5d7eb653d4f3-SEA'
param publicIPAddresses_bb0298af_f10a_4a80_8485_b3678343ba03_externalid string = '/subscriptions/09f867a5-6bb2-4dad-ab50-5d7eb653d4f3/resourceGroups/MC_intern-assignment_Aks1_southeastasia/providers/Microsoft.Network/publicIPAddresses/bb0298af-f10a-4a80-8485-b3678343ba03'
param userAssignedIdentities_Aks1_agentpool_externalid string = '/subscriptions/09f867a5-6bb2-4dad-ab50-5d7eb653d4f3/resourceGroups/MC_intern-assignment_Aks1_southeastasia/providers/Microsoft.ManagedIdentity/userAssignedIdentities/Aks1-agentpool'

resource managedClusters_Aks1_name_resource 'Microsoft.ContainerService/managedClusters@2024-09-02-preview' = {
  name: managedClusters_Aks1_name
  location: 'southindia'
  sku: {
    name: 'Base'
    tier: 'Standard'
  }
  kind: 'Base'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    kubernetesVersion: '1.30.9'
    dnsPrefix: '${managedClusters_Aks1_name}-dns'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 2
        vmSize: 'Standard_DS2_v2'
        osDiskSizeGB: 128
        osDiskType: 'Managed'
        kubeletDiskType: 'OS'
        maxPods: 110
        type: 'VirtualMachineScaleSets'
        maxCount: 5
        minCount: 2
        enableAutoScaling: true
        scaleDownMode: 'Delete'
        powerState: {
          code: 'Running'
        }
        orchestratorVersion: '1.30.9'
        enableNodePublicIP: false
        mode: 'System'
        osType: 'Linux'
        osSKU: 'Ubuntu'
        upgradeSettings: {
          maxSurge: '10%'
          maxUnavailable: '0'
        }
        enableFIPS: false
        securityProfile: {
          sshAccess: 'LocalUser'
          enableVTPM: false
          enableSecureBoot: false
        }
      }
    ]
    windowsProfile: {
      adminUsername: 'azureuser'
      enableCSIProxy: true
    }
    servicePrincipalProfile: {
      clientId: 'msi'
    }
    addonProfiles: {
      azureKeyvaultSecretsProvider: {
        enabled: false
      }
      azurepolicy: {
        enabled: false
      }
      omsAgent: {
        enabled: true
        config: {
          logAnalyticsWorkspaceResourceID: workspaces_DefaultWorkspace_09f867a5_6bb2_4dad_ab50_5d7eb653d4f3_SEA_externalid
          useAADAuth: 'true'
        }
      }
    }
    nodeResourceGroup: 'MC_intern-assignment_${managedClusters_Aks1_name}_southeastasia'
    enableRBAC: true
    supportPlan: 'KubernetesOfficial'
    networkProfile: {
      networkPlugin: 'azure'
      networkPluginMode: 'overlay'
      networkPolicy: 'none'
      networkDataplane: 'azure'
      loadBalancerSku: 'Standard'
      loadBalancerProfile: {
        managedOutboundIPs: {
          count: 1
        }
        effectiveOutboundIPs: [
          {
            id: publicIPAddresses_bb0298af_f10a_4a80_8485_b3678343ba03_externalid
          }
        ]
        backendPoolType: 'nodeIPConfiguration'
      }
      podCidr: '10.244.0.0/16'
      serviceCidr: '10.0.0.0/16'
      dnsServiceIP: '10.0.0.10'
      outboundType: 'loadBalancer'
      podCidrs: [
        '10.244.0.0/16'
      ]
      serviceCidrs: [
        '10.0.0.0/16'
      ]
      ipFamilies: [
        'IPv4'
      ]
      podLinkLocalAccess: 'IMDS'
    }
    identityProfile: {
      kubeletidentity: {
        resourceId: userAssignedIdentities_Aks1_agentpool_externalid
        clientId: 'e99a86b2-eac0-4a46-a92d-e33e01e8c23d'
        objectId: 'd21e0af4-6bd5-495c-98da-05fab29d46a0'
      }
    }
    autoScalerProfile: {
      'balance-similar-node-groups': 'false'
      'daemonset-eviction-for-empty-nodes': false
      'daemonset-eviction-for-occupied-nodes': true
      expander: 'random'
      'ignore-daemonsets-utilization': false
      'max-empty-bulk-delete': '10'
      'max-graceful-termination-sec': '600'
      'max-node-provision-time': '15m'
      'max-total-unready-percentage': '45'
      'new-pod-scale-up-delay': '0s'
      'ok-total-unready-count': '3'
      'scale-down-delay-after-add': '10m'
      'scale-down-delay-after-delete': '10s'
      'scale-down-delay-after-failure': '3m'
      'scale-down-unneeded-time': '10m'
      'scale-down-unready-time': '20m'
      'scale-down-utilization-threshold': '0.5'
      'scan-interval': '10s'
      'skip-nodes-with-local-storage': 'false'
      'skip-nodes-with-system-pods': 'true'
    }
    autoUpgradeProfile: {
      upgradeChannel: 'patch'
      nodeOSUpgradeChannel: 'NodeImage'
    }
    disableLocalAccounts: false
    securityProfile: {
      imageCleaner: {
        enabled: true
        intervalHours: 168
      }
      workloadIdentity: {
        enabled: true
      }
    }
    storageProfile: {
      diskCSIDriver: {
        enabled: true
        version: 'v1'
      }
      fileCSIDriver: {
        enabled: true
      }
      snapshotController: {
        enabled: true
      }
    }
    oidcIssuerProfile: {
      enabled: true
    }
    workloadAutoScalerProfile: {}
    azureMonitorProfile: {
      containerInsights: {
        enabled: true
        logAnalyticsWorkspaceResourceId: workspaces_DefaultWorkspace_09f867a5_6bb2_4dad_ab50_5d7eb653d4f3_SEA_externalid
      }
    }
    metricsProfile: {
      costAnalysis: {
        enabled: false
      }
    }
    nodeProvisioningProfile: {
      mode: 'Manual'
    }
    bootstrapProfile: {
      artifactSource: 'Direct'
    }
  }
}

resource managedClusters_Aks1_name_agentpool 'Microsoft.ContainerService/managedClusters/agentPools@2024-09-02-preview' = {
  parent: managedClusters_Aks1_name_resource
  name: 'agentpool'
  properties: {
    count: 2
    vmSize: 'Standard_DS2_v2'
    osDiskSizeGB: 128
    osDiskType: 'Managed'
    kubeletDiskType: 'OS'
    maxPods: 110
    type: 'VirtualMachineScaleSets'
    maxCount: 5
    minCount: 2
    enableAutoScaling: true
    scaleDownMode: 'Delete'
    powerState: {
      code: 'Running'
    }
    orchestratorVersion: '1.30.9'
    enableNodePublicIP: false
    mode: 'System'
    osType: 'Linux'
    osSKU: 'Ubuntu'
    upgradeSettings: {
      maxSurge: '10%'
      maxUnavailable: '0'
    }
    enableFIPS: false
    securityProfile: {
      sshAccess: 'LocalUser'
      enableVTPM: false
      enableSecureBoot: false
    }
  }
}

resource managedClusters_Aks1_name_aksManagedAutoUpgradeSchedule 'Microsoft.ContainerService/managedClusters/maintenanceConfigurations@2024-09-02-preview' = {
  parent: managedClusters_Aks1_name_resource
  name: 'aksManagedAutoUpgradeSchedule'
  properties: {
    maintenanceWindow: {
      schedule: {
        weekly: {
          intervalWeeks: 1
          dayOfWeek: 'Sunday'
        }
      }
      durationHours: 4
      utcOffset: '+00:00'
      startDate: '2025-03-08'
      startTime: '00:00'
    }
  }
}

resource managedClusters_Aks1_name_aksManagedNodeOSUpgradeSchedule 'Microsoft.ContainerService/managedClusters/maintenanceConfigurations@2024-09-02-preview' = {
  parent: managedClusters_Aks1_name_resource
  name: 'aksManagedNodeOSUpgradeSchedule'
  properties: {
    maintenanceWindow: {
      schedule: {
        weekly: {
          intervalWeeks: 1
          dayOfWeek: 'Sunday'
        }
      }
      durationHours: 4
      utcOffset: '+00:00'
      startDate: '2025-03-08'
      startTime: '00:00'
    }
  }
}
