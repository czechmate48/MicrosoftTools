Function Test-PTNewestVersion {

    <#
    .SYNOPSIS
    This cmdlet identifies whether a program matches the specified version
    .DESCRIPTION
    This cmdlet queries CIM using the provided name and compares the version found with the version provided by the 
    $version variable. If the versions match, the cmdlet returns true. If the versions do not match, the cmdlet returns false.
    If the program is not present, the cmdlet with exit. 
    .PARAMETER Name
    The name of the program being queried
    .PARAMETER Version
    The version to compare the program against
    .EXAMPLE
    Test-NewestVersion -Name 'Firefox' -Version x.x.x.x
    .EXAMPLE
    'Chrome' | Test-NewestVersion -Version x.x.x.x
    .NOTES
    This cmdlet has been tested on the Windows 10 operating system. Functionality not guaranteed on other operating systems. Visit my github 
    at https://github.com/czechmate48 for more cmdlets and scripts related to windows security. 
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [String] $Name,
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [String] $Version
    )

    BEGIN {}

    PROCESS {

        Try {
            Write-Verbose -Message "Getting the Cim Instance of the program $Name"
            $program = Get-CimInstance cim_product | Where-Object -Property Name -like "*$Name*" -ErrorAction Stop
            $program_name = $program.Name
            Write-Verbose -Message "$program_name found"
        } Catch {
            Write-Verbose -Message "Unable to find a program with a name similar to $Name"
            Write-Verbose -Message 'Exiting cmdlet'
            exit
        }
        
        $program_version = $program.Version
        Write-Verbose "$program_name version is $program_version"

        if ($program_version -like "*$version*"){
            Write-Verbose "$program_name matches version $version"
            return $true
        } else {
            Write-Verbose "$program_name does not match version $version"
            return $false
        }
    }

    END {}
}

