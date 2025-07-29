<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000052
    PowerShell Script to Configure ECC Curves priority

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000052).ps1 
#>


$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$valueName = "EccCurves"
$desiredValue = @("NistP384", "NistP256")  # Prioritize NistP384 first

# Create the registry path if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the ECC curves priority (REG_MULTI_SZ)
Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type MultiString

# Confirm the value is set
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName
Write-Output "EccCurves is set to: $($currentValue.$valueName -join ', ')"

