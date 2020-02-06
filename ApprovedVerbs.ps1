# Update as needed

# https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7

# Only commands that begin with approved verbs will be exported in the .psm1 file

Class ApprovedVerbs {
    [String[]] $Common = @(
            'Add',
            'Clear',
            'Close',
            'Copy',
            'Enter',
            'Exit',
            'Find',
            'Format',
            'Get',
            'Hide',
            'Join',
            'Lock',
            'Move',
            'New',
            'Open',
            'Optimize',
            'Pop',
            'Push',
            'Redo',
            'Remove',
            'Rename',
            'Reset',
            'Search',
            'Select',
            'Set',
            'Show',
            'Skip',
            'Split',
            'Step',
            'Switch',
            'Undo',
            'Unlock',
            'Watch'
    )

    [String[]] $Communications = @(
        'Connect',
        'Disconnect',
        'Read',
        'Receive',
        'Send',
        'Write'
    )

    [String[]] $Data = @(
        'Backup',
        'Checkpoint',
        'Compare',
        'Compress',
        'Convert',
        'ConvertFrom',
        'ConvertTo',
        'Dismount',
        'Edit',
        'Expand',
        'Export',
        'Group',
        'Import',
        'Initialize',
        'Limit',
        'Merge',
        'Mount',
        'Out',
        'Publish',
        'Restore',
        'Save',
        'Sync',
        'Unpublish',
        'Update'
    )

    [String[]] $Diagnostic = @(
        'Debug',
        'Measure',
        'Ping',
        'Repair',
        'Resolve',
        'Test',
        'Trace'
    )

    [String[]] $Lifecycle = @(
        'Approve',
        'Assert',
        'Build',
        'Complete',
        'Confirm',
        'Deny',
        'Deploy',
        'Disable',
        'Enable',
        'Install',
        'Invoke',
        'Register',
        'Request',
        'Restart',
        'Resume',
        'Start',
        'Stop',
        'Submit',
        'Suspend',
        'Uninstall',
        'Unregister',
        'Wait'
    )

    [String[]] $Security = @(
        'Block',
        'Grant',
        'Protect',
        'Revoke',
        'Unblock',
        'Unprotect'
    )

    [String[]] $Other = @(
        'Use'
    )

    [String[]] $All = @()

    ApprovedVerbs(){
        $this.All = `
            $this.Common + `
            $this.Communications + `
            $this.Data + `
            $this.Diagnostic + `
            $this.Lifecycle + `
            $this.Security + `
            $this.Other
    }
}

Class ApprovedVerbsValidationSet : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]] GetValidValues() {
        $approvedVerbs = [ApprovedVerbs]::new()
        return [String[]] $approvedVerbs.All
    }
}