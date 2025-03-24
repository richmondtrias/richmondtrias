<#
.SYNOPSIS
    PowerShell script to enforce screen lock timeout policy per STIG WN10-SO-000070

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-03-24
    Last Modified   : 2025-03-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000070

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000070).ps1 
#>

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "InactivityTimeoutSecs"
$desiredValue = 900  # 15 minutes

# Check if the key exists, and create it if not
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Get the current value (if it exists)
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Only set the value if it's missing, too high, or disabled (0)
if ($null -eq $currentValue -or $currentValue -eq 0 -or $currentValue -gt $desiredValue) {
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "InactivityTimeoutSecs set to $desiredValue seconds."
} else {
    Write-Output "InactivityTimeoutSecs is already compliant (Current: $currentValue seconds)."
}
