<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000190
    PowerShell Script to Disable AutoPlay for all drives

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000190

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000190).ps1 
#>

$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName = "NoDriveTypeAutoRun"
$desiredValue = 0x000000FF

# Check if the key exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Compare and set if necessary
if ($currentValue -ne $desiredValue) {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "NoDriveTypeAutoRun set to 0xFF (255) to disable AutoPlay on all drives."
} else {
    Write-Output "NoDriveTypeAutoRun is already correctly set to 0xFF (255)."
}

