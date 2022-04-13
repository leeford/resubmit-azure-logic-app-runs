# Resubmit Azure Logic App Runs

![image](https://user-images.githubusercontent.com/472320/163171256-2fb812cd-4f12-40ed-856f-825400a8b2d9.png)

Sometimes, things don't go according to plan. For example, you may need to re-submit (re-run) some Azure Logic App runs. If its a handful, this is easily done in the Azure Portal one-by-one. If its 100s or even 1000s, this will be very time consuming! Thankfully, there is a way to automate this!

This script allows you to resubmit Azure Logic App runs in bulk (using PowerShell and `az` cli)

## Pre-requisites

You will need to have Azure CLI and PowerShell installed on your machine. Or, use [Azure Cloud Shell](https://shell.azure.com)

> Note: I have only tested this using PowerShell Core 7.2

## Usage

Here are some common usage scenarios.

### Resubmit all Logic App runs (for specified Logic App) from the last 24 hours

```powershell
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name>
```

### Resubmit **Failed** Logic App runs (for specified Logic App) from the last 24 hours

```powershell
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -Status Failed
```

### Resubmit all Logic App runs (for specified Logic App) from specified date (in YYYY-MM-DDTHH:MM:SSZ format)

```powershell
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -AfterDate YYYY-MM-DDTHH:MM:SSZ
```

### Resubmit **Cancelled** Logic App runs (for specified Logic App) from specified date (in YYYY-MM-DDTHH:MM:SSZ format)

```powershell
ResubmitLogicAppRuns.ps1 -SubscriptionId <Subscription ID> -ResourceGroupName <Resource Group Name> -LogicAppName <Logic App Name> -AfterDate YYYY-MM-DDTHH:MM:SSZ -Status Cancelled
```

## Parameters

The script accepts the following parameters:

| Parameter |  Details |
| --------- |------- |
| SubscriptionId | ID of the Azure Subscription where the Logic App resides |
| ResourceGroupName | Name of the Azure Resource Group that contains the Logic App |
| LogicAppName | Name of Logic App |
| AfterDate | Find Logic App runs after this date. Required to be in _YYYY-MM-DDTHH:MM:SSZ_ format (e.g. 2022-04-01T01:00:00Z would be 1st April 2022 at 1AM UTC) |
| Status | Which [run status](https://docs.microsoft.com/en-us/rest/api/logic/workflow-runs/get#workflowstatus) to re-submit. If omitted, all run status are re-submitted |
| DelayBetweenRuns | Delay (in _ms_) between each re-submitted run. Useful if the runs may fail being resubmitted too close to each other. e.g., being throttled by an API. Defaults to 1000ms

## Need Help?

If you are having trouble, have a suggestion or comment, message me on [Twitter](https://www.twitter.com/lee_ford) or raise an issue.
