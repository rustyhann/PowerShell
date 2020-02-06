<#
    .SYNOPSIS
    Invokes Pester for all unit tests in the module and provides a code
    coverage report.

    .DESCRIPTION
    Code coverage can only be done per file, so this will find all Pester
    unit test files, associate them with their respective *.ps1 files, and then
    run unit tests with code coverage. It will then aggregate the results into
    a final code coverage report for the entire module. This script is not
    included in the module and will not be exported as a command.

    .EXAMPLE
    .\Invoke-UnitTests.ps1

    .NOTES
#>
[CmdletBinding()]
Param()
Begin {
    Import-Module Pester -Force
    Import-Module .\Module.psd1 -Force
    $tests = @()
}
Process {
    $testFiles = Get-ChildItem $PSScriptRoot -Recurse -Force | `
        Where-Object { $_.Name -like '*.tests.ps1' } | `
        Select-Object -Property FullName, DirectoryName

    ForEach ($testFile in $testFiles) {
        $script = $testFile.FullName

        $codeCoverage = $testFile.FullName -replace '.tests.', '.'

        $testResult = Invoke-Pester `
            -Script $script `
            -CodeCoverage $codeCoverage `
            -PassThru

        $tests += [PSCustomObject]@{
            FailedCount              = $testResult.FailedCount
            InconclusiveCount        = $testResult.InconclusiveCount
            PassedCount              = $testResult.PassedCount
            PendingCount             = $testResult.PendingCount
            SkippedCount             = $testResult.SkippedCount
            TotalCount               = $testResult.TotalCount
            NumberOfCommandsAnalyzed = $testResult.CodeCoverage.NumberOfCommandsAnalyzed
            NumberOfCommandsExecuted = $testResult.CodeCoverage.NumberOfCommandsExecuted
            NumberOfCommandsMissed   = $testResult.CodeCoverage.NumberOfCommandsMissed
            DirectoryName            = $testFile.DirectoryName
            TestFile                 = $testFile
            ScriptFile               = $scriptFile
        }
    }

    $tests.FailedCount | ForEach-Object { $failedCount += $_ }
    $tests.InconclusiveCount | ForEach-Object { $inconclusiveCount += $_ }
    $tests.PassedCount | ForEach-Object { $passedCount += $_ }
    $tests.PendingCount | ForEach-Object { $pendingCount += $_ }
    $tests.SkippedCount | ForEach-Object { $skippedCount += $_ }
    $tests.TotalCount | ForEach-Object { $totalCount += $_ }
    $tests.NumberOfCommandsAnalyzed | ForEach-Object { $numberOfCommandsAnalyzed += $_ }
    $tests.NumberOfCommandsExecuted | ForEach-Object { $numberOfCommandsExecuted += $_ }
    $tests.NumberOfCommandsMissed | ForEach-Object { $numberOfCommandsMissed += $_ }

    $total = [PSCustomObject]@{
        FailedCount              = $failedCount
        InconclusiveCount        = $inconclusiveCount
        PassedCount              = $passedCount
        PendingCount             = $pendingCount
        SkippedCount             = $skippedCount
        TotalCount               = $totalCount
        NumberOfCommandsAnalyzed = $numberOfCommandsAnalyzed
        NumberOfCommandsExecuted = $numberOfCommandsExecuted
        NumberOfCommandsMissed   = $numberOfCommandsMissed
        PassRate                 = ($PassedCount / $TotalCount).ToString("P")
        CodeCoverage             = ($numberOfCommandsAnalyzed / $numberOfCommandsExecuted).ToString("P")
    }

    $total
}
