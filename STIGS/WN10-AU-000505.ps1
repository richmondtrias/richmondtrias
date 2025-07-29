<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-AU-000505
    PowerShell Script to Ensure Security Event Log Size is 1024000 KB or Greater

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-28
    Last Modified   : 2025-0-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000505).ps1 
#>

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$valueName = "MaxSize"
$requiredSizeKB = 1024000

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    Write-Output "Registry path not found. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Check current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Output "MaxSize value not found. Setting to $requiredSizeKB KB."
    New-ItemProperty -Path $registryPath -Name $valueName -Value $requiredSizeKB -PropertyType DWORD -Force | Out-Null
} elseif ($currentValue.$valueName -lt $requiredSizeKB) {
    Write-Output "Current MaxSize is $($currentValue.$valueName) KB, which is less than required. Updating..."
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $requiredSizeKB
} else {
    Write-Output "Current MaxSize is $($currentValue.$valueName) KB, which meets or exceeds requirement. No action needed."
}

# Confirm the change
$confirmedValue = Get-ItemProperty -Path $registryPath -Name $valueName
Write-Output "MaxSize is now set to $($confirmedValue.$valueName) KB."
