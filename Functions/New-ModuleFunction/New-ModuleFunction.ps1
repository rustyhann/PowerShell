Function New-ModuleFunction() {
    [CmdletBinding()]
    Param(
        [String]
        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateSet([ApprovedVerbsValidationSet])]
        $Verb,

        [string]
        [Parameter(Mandatory = $true, Position = 2)]
        $Name
    )

    Begin {
        $ErrorActionPreference = 'Stop'
    }
    Process {

    }
    End { }
}