<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000250
    PowerShell Script to enable Windows Defender SmartScreen in Microsoft Edge

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000250

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000250).ps1 
#>

# PowerShell Script to enable Windows Defender SmartScreen in Microsoft Edge
# STIG: WN10-CC-000250

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
$valueName = "EnabledV9"
$desiredValue = 0x00000001

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Compare and set if needed
if ($currentValue -ne $desiredValue) {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "SmartScreen filter enabled: EnabledV9 set to 1 in Microsoft Edge."
} else {
    Write-Output "SmartScreen filter is already enabled in Microsoft Edge."
}


