<#
.SYNOPSIS
    PowerShell script to implement STIG ID: WN10-AU-000510
    PowerShell Script to Ensure System Event Log Size is 32768 KB or Greater

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-28
    Last Modified   : 2025-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000510).ps1 
#>


$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\System"
$valueName = "MaxSize"
$requiredSizeKB = 32768

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    Write-Output "Registry path not found. Creating path: $registryPath"
    New-Item -Path $registryPath -Force | Out-Null
}

# Get current value if it exists
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
