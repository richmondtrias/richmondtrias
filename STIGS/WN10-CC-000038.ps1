<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000038
    PowerShell Script to Disable WDigest Authentication

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-28
    Last Modified   : 2025-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000038

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000038).ps1 
#>


$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\Wdigest"
$valueName = "UseLogonCredential"
$desiredValue = 0

# Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    Write-Output "Registry path not found. Creating: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value if it exists
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Output "'$valueName' not found. Creating with value $desiredValue."
    New-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -PropertyType DWORD -Force | Out-Null
} elseif ($currentValue.$valueName -ne $desiredValue) {
    Write-Output "'$valueName' is set to $($currentValue.$valueName). Updating to $desiredValue."
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue
} else {
    Write-Output "'$valueName' is already correctly set to $desiredValue. No action needed."
}

# Confirm the setting
$confirmed = Get-ItemProperty -Path $registryPath -Name $valueName
Write-Output "Final setting: '$valueName' = $($confirmed.$valueName)"
