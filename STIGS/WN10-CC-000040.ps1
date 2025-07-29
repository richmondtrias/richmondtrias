<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000040
    PowerShell Script to Disable insecure guest logons to SMB server

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000040

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000040).ps1 
#>


$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"
$valueName = "AllowInsecureGuestAuth"
$desiredValue = 0

# Create the registry path if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord

# Confirm the value is set
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName
Write-Output "AllowInsecureGuestAuth is set to $($currentValue.$valueName)"


# Confirm the setting
$confirmed = Get-ItemProperty -Path $registryPath -Name $valueName
Write-Output "Final setting: '$valueName' = $($confirmed.$valueName)"
