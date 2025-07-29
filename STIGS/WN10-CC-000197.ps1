<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000197
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
    STIG-ID         : WN10-CC-000197

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000197).ps1 
#>

# PowerShell Script to disable Microsoft Consumer Experiences (STIG: WN10-CC-000197)

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$valueName = "DisableWindowsConsumerFeatures"
$desiredValue = 0x00000001

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Get the current value if it exists
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Compare and set if necessary
if ($currentValue -ne $desiredValue) {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "Microsoft Consumer Experiences disabled (DisableWindowsConsumerFeatures set to 1)."
} else {
    Write-Output "Microsoft Consumer Experiences is already disabled."
}


