<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000068
    PowerShell Script to Enable delegation of non-exportable credentials

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000068

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000068).ps1 
#>

# Enable delegation of non-exportable credentials (STIG ID: WN10-CC-000068)

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
$valueName = "AllowProtectedCreds"
$desiredValue = 1

# Create the registry path if it does not exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord

# Confirm the setting
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName
Write-Output "AllowProtectedCreds is set to $($currentValue.$valueName)"

