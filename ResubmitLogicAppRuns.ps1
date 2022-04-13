# Resubmit Logic App Runs
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $SubscriptionId,
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]
    $LogicAppName,
    [Parameter(mandatory = $false)]
    [switch]
    $FailedOnly,
    [Parameter(Mandatory = $false)]
    [string]
    $AfterDate = ((Get-Date).AddDays(-1).ToUniversalTime().tostring("yyyy-MM-ddTHH:mm:ssZ")),
    [Parameter(mandatory = $false)]
    [int]
    $DelayBetweenRuns = 1000
)

# Validate subscription
Write-Host "Validating subscription... "
if ($SubscriptionId -ne "") {
    az account set -s $SubscriptionId
    if (!$?) { 
        Write-Error "Unable to select $SubscriptionId as the active subscription"
        exit 1
    }
    Write-Host "Active subscription set to $SubscriptionId" -ForegroundColor Green
}
else {
    $Subscription = az account show | ConvertFrom-Json
    $SubscriptionId = $Subscription.id
    $SubscriptionName = $Subscription.name
    Write-Host "Active subscription is $SubscriptionId ($SubscriptionName)" -ForegroundColor Green
}

# Get Logic App Details
Write-Host "Checking Logic App: $($LogicAppName)..."
$LogicApp = az rest `
    --url "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.Logic/workflows/$($LogicAppName)?api-version=2016-06-01" | ConvertFrom-Json
if (!$?) { 
    Write-Error "An error occured getting Logic App"
    exit 1
}
if ($LogicApp.name) {
    Write-Host "Logic App: $($LogicApp.name) found" -ForegroundColor Green
    # Get Logic App Run History
    if ($FailedOnly) {
        $filters = "startTime ge $($AfterDate) and status eq 'Failed'"
    }
    else {
        $filters = "startTime ge $($AfterDate)"
    }
    Write-Host "Getting Logic App runs..."
    Write-Host " - After: $($AfterDate)"
    if ($FailedOnly) { Write-Host " - Only Failed runs" }
    # Loop through each batch of runs (if required)
    $currentUri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.Logic/workflows/$($LogicAppName)/runs?api-version=2016-06-01&`$filter=$filters"
    $LogicAppRuns = while (-not [string]::IsNullOrEmpty($currentUri)) {
        $apiCall = az rest `
            --url $currentUri | ConvertFrom-Json
        if (!$?) { 
            Write-Error "An error occured getting Logic App Runs"
            exit 1
        }
        if ($apiCall.nextLink) {
            $currentUri = $apiCall.nextLink
        }
        else {
            $currentUri = $null
        }
        # Return data
        $apiCall.value
    }
}

# Resubmit runs
$totalRuns = ($LogicAppRuns).count
Write-Host "$($totalRuns) Logic App runs found" -ForegroundColor Green
$LogicAppRuns | ForEach-Object {
    $count++
    Write-Host "Logic App Run ($($count)/$($totalRuns)):" -ForegroundColor Yellow
    Write-Host " - Resubmitting run: $($_.name)..."
    az rest `
        --method POST `
        --url "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroupName)/providers/Microsoft.Logic/workflows/$($LogicAppName)/triggers/$($_.properties.trigger.name)/histories/$($_.name)/resubmit?api-version=2016-06-01" | ConvertFrom-Json
    if (!$?) { 
        Write-Host "FAILED" -ForegroundColor Red
    }
    else {
        Write-Host "SUCCESS" -ForegroundColor Green
    }
    Start-Sleep -Milliseconds $DelayBetweenRuns
}