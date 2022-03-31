# Resubmit Azure Logic App Runs
![image](https://user-images.githubusercontent.com/472320/161092468-07b504f3-6cda-4a1f-be23-41235216eb33.png)

A PowerShell script to allow you to resubmit Azure Logic App runs in bulk (using `az` cli)

## Pre-requisites
You will need to have Azure CLI and PowerShell installed on your machine. Or, use [Azure Cloud Shell](https://shell.azure.com)

## Usage

_Resubmit all Logic App runs (for specified Logic App) from the last 24 hours_
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name>
```

_Resubmit **failed** Logic App runs (for specified Logic App) from the last 24 hours_
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -FailedOnly
```

_Resubmit all Logic App runs (for specified Logic App) from specified date (in YYYY-MM-DDTHH:MM:SSZ format)_
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -AfterDate YYYY-MM-DDTHH:MM:SSZ
```

_Resubmit **failed** Logic App runs (for specified Logic App) from specified date (in YYYY-MM-DDTHH:MM:SSZ format)_
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -AfterDate YYYY-MM-DDTHH:MM:SSZ -FailedOnly
```
