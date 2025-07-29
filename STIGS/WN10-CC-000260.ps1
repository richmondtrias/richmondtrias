<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-CC-000260
    PowerShell Script to enforce minimum PIN length of 6 or more characters

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-29
    Last Modified   : 2025-07-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000260

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000260).ps1 
#>

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity"
$valueName = "MinimumPINLength"
$desiredValue = 6  # You can change this to a higher number if needed (e.g., 8)

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Get current value if it exists
$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

# Compare and set if needed
if ($currentValue -lt $desiredValue) {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Output "Minimum PIN length configured to $desiredValue."
} else {
    Write-Output "Minimum PIN length is already set to $currentValue, which meets or exceeds the requirement."
}


