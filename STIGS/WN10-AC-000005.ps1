<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-07-28
    Last Modified   : 2025-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>

# PowerShell script to check and enforce STIG ID: WN10-AC-000005

# Import necessary module
Import-Module SecurityPolicyDSC -ErrorAction SilentlyContinue

# Get current Account lockout duration
$currentDuration = (secedit /export /cfg "$env:TEMP\secpol.cfg") > $null
$durationLine = Select-String -Path "$env:TEMP\secpol.cfg" -Pattern "^LockoutDuration"

if ($durationLine) {
    $currentValue = ($durationLine -split "=")[1].Trim()
    Write-Output "Current Account Lockout Duration: $currentValue minute(s)"

    if ($currentValue -eq "0") {
        Write-Output "Setting is 0 (admin unlock required) — this is compliant."
    }
    elseif ([int]$currentValue -lt 15) {
        Write-Output "Non-compliant. Updating lockout duration to 15 minutes..."
        
        # Use ntrights to apply the correct setting via secedit INF file
        $infPath = "$env:TEMP\stig_lockout_duration.inf"
        $sdbPath = "$env:TEMP\stig_lockout_duration.sdb"
        Set-Content -Path $infPath -Value @"
[Unicode]
Unicode=yes
[System Access]
LockoutDuration = 15
"@

        secedit /configure /db $sdbPath /cfg $infPath /quiet
        Write-Output "Lockout duration successfully set to 15 minutes."
    }
    else {
        Write-Output "Lockout duration is already compliant."
    }

    # Clean up
    Remove-Item "$env:TEMP\secpol.cfg","$infPath","$sdbPath" -ErrorAction SilentlyContinue
} else {
    Write-Output "Failed to read current lockout duration setting."
}
