<#
.SYNOPSIS
    PowerShell script to disable the Guest account per STIG WN10-SO-000010

.NOTES
    Author          : Richmond Trias
    LinkedIn        : linkedin.com/in/richmondtrias/
    GitHub          : https://github.com/richmondtrias
    Date Created    : 2025-03-24
    Last Modified   : 2025-03-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000010).ps1 
#>


# Check if Guest account exists
$guestAccount = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue

if ($null -ne $guestAccount) {
    if (-not $guestAccount.Enabled) {
        Write-Output "Guest account is already disabled."
    } else {
        Disable-LocalUser -Name "Guest"
        Write-Output "Guest account has been disabled."
    }
} else {
    Write-Output "Guest account does not exist or cannot be found."
}
