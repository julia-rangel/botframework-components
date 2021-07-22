# 
# Updates-Versions
#
# Update the SDK and branch versions of the packages along with their dependencies
#
Param
(
    [parameter(Mandatory = $true)]
    [string] $CurrentBotSdkVersion,
    [string] $NewBotSdkVersion,
    [parameter(Mandatory = $true)]
    [string] $CurrentPackageVersion,
    [parameter(Mandatory = $true)]
    [string] $NewPackageVersion,
    [parameter(Mandatory = $true)]
    [string] $SearchRoot
)

# We will still require current Bot SDK version to validate the branch is still in a good state.
if ([string]::IsNullOrEmpty($NewBotSdkVersion))
{
    Write-Host "No new Bot Framework SDK version specified. We will not update SDK version." -ForegroundColor Yellow
    $NewBotSdkVersion = $CurrentBotSdkVersion
}

# Diagnostic outputs
Write-Host "Current SDK Version:" $CurrentBotSdkVersion -ForegroundColor Green
Write-Host "New SDK Version:"$NewBotSdkVersion -ForegroundColor Green
Write-Host "Current Package Version:"$CurrentPackageVersion -ForegroundColor Green
Write-Host "New Package Version:"$NewPackageVersion -ForegroundColor Green
Write-Host "Search Root:" $SearchRoot -ForegroundColor Green

# Scan for all the files from the root that resembles any of the following file name pattern
# *.csproj, index.js (for generators), package.json (for any package references)
Get-ChildItem -Path $SearchRoot -Filter package.json -Include  -Recurse | ForEach-Object { Write-Host $_.FullName }