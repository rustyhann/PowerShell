$ErrorActionPreference = 'Stop'

# Load the approved verbs class

. $PSScriptRoot\ApprovedVerbs.ps1

<#
    Dot source *.ps1 files.
    Exclude Pester test files that follow *.tests.ps1 naming convention.
    Exclude the approved verbs list.
    Exclude the unit testing script.
    Exclude any private *.ps1 files used by individual commands.
    Exclude any resources (json, etc.) used by individual commands.
#>

Get-ChildItem $PSScriptRoot -Recurse | Where-Object {
    ($_.Name -like '*.ps1') -and `
    ($_.Name -notlike '*.tests.ps1') -and `
    ($_.Name -ne 'ApprovedVerbs.ps1') -and `
    ($_.Name -ne 'Invoke-UnitTests.ps1') -and `
    ($_.FullName -notmatch 'Private')
} | ForEach-Object {
    . $_.FullName
}

# We will only export modules that start with Approved verbs.

$approvedVerbs = [ApprovedVerbs]::new()
ForEach ($verb in $approvedVerbs.All) {
    Export-ModuleMember -Function "$verb-*"
}