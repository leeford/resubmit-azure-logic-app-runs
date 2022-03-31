# resubmit-azure-logic-app-runs
![image](https://user-images.githubusercontent.com/472320/161092468-07b504f3-6cda-4a1f-be23-41235216eb33.png)

A PowerShell script to allow you to resubmit Azure Logic App runs in bulk (using `az` cli)

Resubmit all Logic App runs (for specified Logic App) from the last 24 hours
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name>
```

Resubmit **failed** Logic App runs (for specified Logic App) from the last 24 hours
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -FailedOnly
```

Resubmit all Logic App runs (for specified Logic App) from specified date (in YYYY-MM-DDTHH:MM:SSZ format)
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -AfterDate YYYY-MM-DDTHH:MM:SSZ
```

Resubmit **failed** Logic App runs (for specified Logic App) from specified date (in YYYY-MM-DDTHH:MM:SSZ format)
```
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -AfterDate YYYY-MM-DDTHH:MM:SSZ -FailedOnly
```
